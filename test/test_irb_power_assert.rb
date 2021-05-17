# coding: utf-8
# frozen_string_literal: true

require_relative 'helper'

require 'stringio'

class TestIRBPowerAssert < Test::Unit::TestCase
  # Taken from https://github.com/ruby/irb/blob/ad08152c43d4309ee4dec3bbaf361ffc338c1f46/test/irb/test_cmd.rb#L8-L32, thank you!(I don't know what is this...)
  class InputMethod < ::IRB::InputMethod
    attr_reader :list, :line_no

    def initialize(list = [])
      super('test')
      @line_no = 0
      @list = list
    end

    def gets
      @list[@line_no]&.tap { @line_no += 1 }
    end

    def eof?
      @line_no >= @list.size
    end

    def encoding
      Encoding.default_external
    end

    def reset
      @line_no = 0
    end
  end

  def test_constants
    assert(IRB::PowerAssert::VERSION.frozen?)
    assert do
      Gem::Version.correct?(IRB::PowerAssert::VERSION)
    end

    am = method(:assert_match)
    ::PowerAssert.class_exec do
      am.call(%r{/irb-power_assert/lib\z}, const_get(:INTERNAL_LIB_DIRS)[IRB::PowerAssert])
    end
  end

  def test_typical_example
    IRB.setup(__FILE__, argv: [])
    IRB.conf[:USE_MULTILINE] = true
    IRB.conf[:USE_SINGLELINE] = false
    IRB.conf[:VERBOSE] = false
    workspace = IRB::WorkSpace.new(self)
    irb = IRB::Irb.new(workspace, InputMethod.new([]))
    IRB.conf[:MAIN_CONTEXT] = irb.context

    expected =<<~'EOD'
    result: false

    "0".class == "3".to_i.times.map {|i| i + 1 }.class
        |     |      |    |     |                |
        |     |      |    |     |                Array
        |     |      |    |     [1, 2, 3]
        |     |      |    #<Enumerator: ...>
        |     |      3
        |     false
        String
    EOD

    out, err = capture_output do
      irb.context.main.irb_pa(%q{"0".class == "3".to_i.times.map {|i| i + 1 }.class})
    end
    assert_equal('', err)
    assert_equal(expected, out)
  end
end
