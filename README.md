# irb-power_assert

[![Build Status](https://github.com/kachick/irb-power_assert/actions/workflows/ci-ruby.yml/badge.svg?branch=main)](https://github.com/kachick/irb-power_assert/actions/workflows/ci-ruby.yml?query=branch%3Amain+)
[![Gem Version](https://badge.fury.io/rb/irb-power_assert.svg)](http://badge.fury.io/rb/irb-power_assert)

Use power_assert inspection in irb

## Usage

Requires Ruby 4.0, 3.4, or newer.

```console
$ gem install irb-power_assert
...installed
```

```console
$ irb -r irb-power_assert
# enabled this gem
```

Or specify in your `~/.irbrc` as below

```ruby
require 'irb/power_assert'
```

```console
$ irb
irb(main):004> help pa
Print PowerAssert inspection for the given expression.
```

Then you can use `pa` as an IRB command.

```ruby
irb(main):001:0> pa "0".class == "3".to_i.times.map {|i| i + 1 }.class
"0".class == "3".to_i.times.map {|i| i + 1 }.class
    |     |      |    |     |                |
    |     |      |    |     |                Array
    |     |      |    |     [1, 2, 3]
    |     |      |    #<Enumerator: ...>
    |     |      3
    |     false
    String

=> false
```

No hack is needed in your irbrc

## Thanks!

[ruby/power_assert](https://github.com/ruby/power_assert) is a recent my favorites.\
(the author is [@k-tsj](https://github.com/k-tsj), thank you!)

It is super helpful in complex testing.

I just would get irb version of
[yui-knk/pry-power_assert](https://github.com/yui-knk/pry-power_assert).

Latest IRB is much helpful to [create own command](https://github.com/ruby/irb/pull/886)

Honor should be bestowed upon them.

## References

- [power-assert-js/power-assert](https://github.com/power-assert-js/power-assert)
- [Power Assert in Ruby](https://speakerdeck.com/k_tsj/power-assert-in-ruby)
- [pry-power_assert implementation](https://github.com/yui-knk/pry-power_assert/blob/2d10ee3df8efaf9c448f31d51bff8033a1792739/lib/pry-power_assert.rb#L26-L35)
