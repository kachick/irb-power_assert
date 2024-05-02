# coding: us-ascii
# frozen_string_literal: true

require 'power_assert'
require 'power_assert/colorize'

module IRB
  class PaCommand < IRB::Command::Base
    description 'Show inspections for each result.'
    category 'Misc'
    help_message 'Print PowerAssert inspection for the given expression.'

    def usage
      <<~'EOD'
        `pa` command will work for expressions that includes method calling.
        e.g. `pa (2 * 3 * 7).abs == 1010102.to_s.to_i(2)`
      EOD
    end

    def execute(expression)
      if expression == ''
        # Avoid warn and raise here, warn does not appear in irb and exception sounds like a IRB bug
        puts usage
        return
      end

      result = nil
      inspection = nil
      ::PowerAssert.start(expression, source_binding: irb_context.workspace.binding) do |pa|
        result = pa.yield
        inspection = pa.message_proc.call
      end

      if inspection == ''
        puts usage
      else
        puts inspection, "\n"
      end

      puts "=> #{result.inspect}"
    end
  end

  Command.register(:pa, PaCommand)
end
