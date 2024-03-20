# coding: us-ascii
# frozen_string_literal: true

require 'irb/cmd/nop'
require 'power_assert'
require 'power_assert/colorize'

module IRB
  module ExtendCommand
    class Pa < Nop
      def execute(expression)
        # The implementation basically taken from https://github.com/yui-knk/pry-power_assert/blob/2d10ee3df8efaf9c448f31d51bff8033a1792739/lib/pry-power_assert.rb#L26-L35, thank you!
        result = ['result: ']

        ::PowerAssert.start(expression, source_binding: irb_context.workspace.binding) do |pa|
          result << pa.yield.inspect
          result << "\n\n"
          result << pa.message_proc.call
        end

        puts result.join
      end
    end
  end
end
