# frozen_string_literal: true

require 'irb/power_assert'

# This logic taken from following reference, @k0kubun thank you!
#  * https://github.com/k0kubun/dotfiles/blob/8762ee623adae0fba20ed0a5ef7c8ff5825dc20a/config/.irbrc#L241-L262
#  * https://k0kubun.hatenablog.com/entry/2021/04/02/211455
IRB::Context.prepend(Module.new{
  kwargs = Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.7.0') ? ', **' : ''
  line = __LINE__; eval %q{
    def evaluate(line, *__ARGS__)
      case line
      when /\Apa /
        line.replace("pa #{line.sub(/\Apa +/, '').strip.dump}\n")
      end
      super
    end
  }.sub(/__ARGS__/, kwargs), nil, __FILE__, line
})
