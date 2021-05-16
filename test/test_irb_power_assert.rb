# coding: utf-8
# frozen_string_literal: true

require_relative 'helper'

require 'stringio'

class TestIRBPowerAssert < Test::Unit::TestCase
  # Taken from https://github.com/ruby/irb/blob/ad08152c43d4309ee4dec3bbaf361ffc338c1f46/test/irb/test_cmd.rb#L8-L32, thank you!(I don't know what is this...)
  class InputMethod < ::IRB::InputMethod
    attr_reader :list, :line_no

    def initialize(list = [])
      super("test")
      @line_no = 0
      @list = list
    end

    def gets
      @list[@line_no]&.tap {@line_no += 1}
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
  end

  def test_mane
    IRB.setup(__FILE__, argv: [])
    IRB.conf[:USE_MULTILINE] = true
    IRB.conf[:USE_SINGLELINE] = false
    IRB.conf[:VERBOSE] = false
    workspace = IRB::WorkSpace.new(self)
    irb = IRB::Irb.new(workspace, InputMethod.new([]))
    IRB.conf[:MAIN_CONTEXT] = irb.context
    expected = "result: false\n\n\"0\".class == \"3\".to_i.times.map {|i| i + 1 }.class\n    |     |      |    |     |                |\n    |     |      |    |     |                Array\n    |     |      |    |     [1, 2, 3]\n    |     |      |    #<Enumerator: ...>\n    |     |      3\n    |     false\n    String\n"

    out, err = capture_output do
      irb.context.main.irb_pa('"0".class == "3".to_i.times.map {|i| i + 1 }.class')
    end
    assert_equal('', err)
    assert_match(expected, out)
  end
end
