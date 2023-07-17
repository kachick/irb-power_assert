# irb-power_assert

[![Build Status](https://github.com/kachick/irb-power_assert/actions/workflows/ci-ruby.yml/badge.svg?branch=main)](https://github.com/kachick/irb-power_assert/actions/workflows/ci-ruby.yml?query=branch%3Amain+)
[![Gem Version](https://badge.fury.io/rb/irb-power_assert.svg)](http://badge.fury.io/rb/irb-power_assert)

## Overview

![screenshot - expression](https://user-images.githubusercontent.com/1180335/119386011-efc1bb00-bd01-11eb-80c4-1aea86fa3781.png)

[ruby/power_assert](https://github.com/ruby/power_assert) is a recent My
favorites. (the author is [@k-tsj](https://github.com/k-tsj), thank you!)

It is super helpful in complex testing.

Don't say [ruby/irb](https://github.com/ruby/irb) is old-fashioned.

I just would get irb version of
[yui-knk/pry-power_assert](https://github.com/yui-knk/pry-power_assert)

Honor should be bestowed upon them.

## Usage

Require Ruby 2.7 or later

This command will install the latest version into your environment

```console
$ gem install irb-power_assert
Should be installed!
```

```console
$ irb -r irb-power_assert
# Then enabled this gem!
```

Or specify in your `~/.irbrc` as below

```ruby
require 'irb/power_assert'
```

```console
$ irb
# Then enabled this gem!
```

Then you can use `pa` as an IRB command.

```ruby
irb(main):001:0> pa %q{ "0".class == "3".to_i.times.map {|i| i + 1 }.class }
result: false

 "0".class == "3".to_i.times.map {|i| i + 1 }.class
     |     |      |    |     |                |
     |     |      |    |     |                Array
     |     |      |    |     [1, 2, 3]
     |     |      |    #<Enumerator: ...>
     |     |      3
     |     false
     String
=> nil
```

So you can see, the `pa` just takes strings of the code.

If you want to directly pass `expression`, below is the hack for single line
code.

Write below code in your `~/.irbrc`

```ruby
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
```

Then you can use the `pa` as below...

```ruby
irb(main):001:0> pa "0".class == "3".to_i.times.map {|i| i + 1 }.class
result: false

"0".class == "3".to_i.times.map {|i| i + 1 }.class
    |     |      |    |     |                |
    |     |      |    |     |                Array
    |     |      |    |     [1, 2, 3]
    |     |      |    #<Enumerator: ...>
    |     |      3
    |     false
    String
=> nil
```

This repository has the example [.irbrc](examples/.irbrc), if you don't have the
file yet, trying it may be fun.

```shell
gem install irb-power_assert
wget 'https://raw.githubusercontent.com/kachick/irb-power_assert/main/examples/.irbrc' -P "$HOME"
irb
```

## References

- [power-assert-js/power-assert](https://github.com/power-assert-js/power-assert)
- [Power Assert in Ruby](https://speakerdeck.com/k_tsj/power-assert-in-ruby)
- [ja - IRB is new than Pry](https://k0kubun.hatenablog.com/entry/2021/04/02/211455)
