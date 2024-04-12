# coding: us-ascii
# frozen_string_literal: true

require 'stringio'
require 'warning'
require 'prettyprint'

# How to use => https://test-unit.github.io/test-unit/en/
require 'test/unit'

Warning[:deprecated] = true
Warning[:experimental] = true

Gem.path.each do |path|
  Warning.ignore(//, path)
end

# https://github.com/kachick/irb-power_assert/issues/176
# https://github.com/ruby/ruby/blob/e5b585ba908d371c67d97988795a5e40ec2f9e93/lib/prettyprint.rb#L184
Warning.ignore(/literal string will be frozen in the future/, PrettyPrint.instance_method(:text).source_location.first)

Warning.process do |_warning|
  :raise
end

require_relative '../lib/irb-power_assert'

module TestIRBPowerAssertHelpers
  class TestInputMethod < ::IRB::InputMethod
    attr_reader :list, :line_no

    def initialize(list = [])
      super()
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

  def execute_lines(*lines, conf: {}, main: self, irb_path: nil)
    raise unless RUBY_VERSION >= '3.4'

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
