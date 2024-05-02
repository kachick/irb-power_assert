# coding: us-ascii
# frozen_string_literal: true

require 'power_assert'
require 'power_assert/colorize'

module IRB
  class PaCommand < IRB::Command::Base
    def execute(expression)
      # The implementation basically taken from https://github.com/yui-knk/pry-power_assert/blob/2d10ee3df8efaf9c448f31d51bff8033a1792739/lib/pry-power_assert.rb#L26-L35, thank you!
      result = +'result: '

      ::PowerAssert.start(expression, source_binding: irb_context.workspace.binding) do |pa|
        result << pa.yield.inspect << "\n\n"
        result << pa.message_proc.call
      end

      puts result
    end
  end

  if ::IRB::Command.respond_to?(:register)
    Command.register(:pa, PaCommand)
  else
    Command::Pa = PaCommand

    module ExtendCommandBundle
      def_extend_command(:irb_pa, :Pa, __FILE__, [:pa, NO_OVERRIDE])
    end
  end
end
