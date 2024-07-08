# coding: utf-8
# frozen_string_literal: true

require_relative 'helper'

require 'stringio'

class TestIRBPowerAssertNoEnv < Test::Unit::TestCase
  def test_constants
    assert(IRB::PowerAssert::VERSION.frozen?)
    assert do
      Gem::Version.correct?(IRB::PowerAssert::VERSION)
    end

    am = method(:assert_match)
    ::PowerAssert.class_exec do
      am.call(%r{#{Regexp.escape(Dir.pwd)}/lib}, const_get(:INTERNAL_LIB_DIRS)[IRB::PowerAssert])
    end
  end
end

class TestIRBPowerAssertWithEnv < Test::Unit::TestCase
  include TestIRBPowerAssertHelpers

  def setup
    @pwd = Dir.pwd
    @tmpdir = File.join(Dir.tmpdir, "test_reline_config_#{$$}")
    begin
      Dir.mkdir(@tmpdir)
    rescue Errno::EEXIST
      FileUtils.rm_rf(@tmpdir)
      Dir.mkdir(@tmpdir)
    end
    Dir.chdir(@tmpdir)
    @home_backup = ENV['HOME']
    ENV['HOME'] = @tmpdir
    @xdg_config_home_backup = ENV.delete('XDG_CONFIG_HOME')
    save_encodings
    IRB.instance_variable_get(:@CONF).clear
    IRB.instance_variable_set(:@existing_rc_name_generators, nil)
    @is_win = (RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|cygwin|bccwin|wince|emc/)
  end

  def teardown
    ENV['XDG_CONFIG_HOME'] = @xdg_config_home_backup
    ENV['HOME'] = @home_backup
    Dir.chdir(@pwd)
    FileUtils.rm_rf(@tmpdir)
    restore_encodings
  end

  def execute_lines(*lines, conf: {}, main: self, irb_path: nil)
    capture_output do
      IRB.init_config(nil)
      IRB.conf[:VERBOSE] = false
      IRB.conf[:PROMPT_MODE] = :SIMPLE
      IRB.conf[:USE_PAGER] = false
      IRB.conf.merge!(conf)
      input = TestInputMethod.new(lines)
      irb = IRB::Irb.new(IRB::WorkSpace.new(main), input)
      irb.context.return_format = "=> %s\n"
      irb.context.irb_path = irb_path if irb_path
      IRB.conf[:MAIN_CONTEXT] = irb.context
      irb.eval_input
    end
  end

  def test_typical_example
    expected =<<~'EOD'
    "0".class == "3".to_i.times.map {|i| i + 1 }.class
        |     |      |    |     |                |
        |     |      |    |     |                Array
        |     |      |    |     [1, 2, 3]
        |     |      |    #<Enumerator: ...>
        |     |      3
        |     false
        String

    => false
    EOD

    out, err = execute_lines(%q{pa "0".class == "3".to_i.times.map {|i| i + 1 }.class})

    assert_equal('', err)
    # TODO: Remove this version guard after dropping to support irb 1.13.x
    # https://github.com/ruby/irb/pull/972
    if Gem::Version.new(IRB::VERSION) >= '1.14'
      assert_equal(expected, out)
    else
      assert_equal(expected + "=> nil\n", out)
    end
  end

  def test_usage
    out, err = execute_lines(%q{pa})

    assert_equal('', err)
    assert_match(/will work for expressions that includes method calling/, out)

    # With whitespace
    out, err = execute_lines(%q{pa    })

    assert_equal('', err)
    assert_match(/will work for expressions that includes method calling/, out)

    # No variable and method callings
    out, err = execute_lines(%q{pa 42})

    assert_equal('', err)
    assert_match(/will work for expressions that includes method calling/, out)

    # Includes method calling will not show usage
    expected =<<~'EOD'
    42.abs
       |
       42

    => 42
    EOD

    out, err = execute_lines(%q{pa 42.abs})

    assert_equal('', err)
    # TODO: Remove this version guard after dropping to support irb 1.13.x
    # https://github.com/ruby/irb/pull/972
    if Gem::Version.new(IRB::VERSION) >= '1.14'
      assert_equal(expected, out)
    else
      assert_equal(expected + "=> nil\n", out)
    end
  end

  def test_help
    out, err = execute_lines(%q{help pa})

    assert_equal('', err)
    assert_match(/Print.+PowerAssert.+inspection/i, out)
  end
end
