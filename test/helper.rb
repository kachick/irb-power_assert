# coding: us-ascii
# frozen_string_literal: true

require 'stringio'
require 'warning'
require 'prettyprint'

# https://test-unit.github.io/test-unit/en/
require 'test/unit'

# https://github.com/ruby/test-unit-ruby-core
require 'envutil'
# Test::Unit::TestCase.include Test::Unit::CoreAssertions

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

  def save_encodings
    @default_encoding = [Encoding.default_external, Encoding.default_internal]
    @stdio_encodings = [STDIN, STDOUT, STDERR].map { |io| [io.external_encoding, io.internal_encoding] }
  end

  def restore_encodings
    EnvUtil.suppress_warning do
      Encoding.default_external, Encoding.default_internal = *@default_encoding
      [STDIN, STDOUT, STDERR].zip(@stdio_encodings) do |io, encs|
        io.set_encoding(*encs)
      end
    end
  end
end
