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

class Test::Unit::TestCase
  # Taken from https://github.com/ruby/irb/blob/ad08152c43d4309ee4dec3bbaf361ffc338c1f46/test/lib/minitest/unit.rb#L461-L495, thank you!
  def capture_io
    captured_stdout, captured_stderr = StringIO.new, StringIO.new

    orig_stdout, orig_stderr = $stdout, $stderr
    $stdout, $stderr         = captured_stdout, captured_stderr

    begin
      yield
    ensure
      $stdout = orig_stdout
      $stderr = orig_stderr
    end

    return captured_stdout.string, captured_stderr.string
  end
  alias_method :capture_output, :capture_io
end
