# irb-power_assert

[![Build Status](https://github.com/kachick/irb-power_assert/actions/workflows/ci-ruby.yml/badge.svg?branch=main)](https://github.com/kachick/irb-power_assert/actions/workflows/ci-ruby.yml?query=branch%3Amain+)
[![Gem Version](https://badge.fury.io/rb/irb-power_assert.svg)](http://badge.fury.io/rb/irb-power_assert)

## Overview

![screenshot - expression](https://user-images.githubusercontent.com/1180335/119386011-efc1bb00-bd01-11eb-80c4-1aea86fa3781.png)

[ruby/power_assert](https://github.com/ruby/power_assert) is a recent my favorites.\
(the author is [@k-tsj](https://github.com/k-tsj), thank you!)

It is super helpful in complex testing.

Don't say [ruby/irb](https://github.com/ruby/irb) is old-fashioned.

I just would get irb version of
[yui-knk/pry-power_assert](https://github.com/yui-knk/pry-power_assert)

Honor should be bestowed upon them.

## Usage

Require Ruby 3.2 or higher # Tested only in ruby-head and the last 2 stable versions

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

The `pa` just takes strings of the code.

If you want to directly pass `expression`, [.irbrc](examples/.irbrc) is the hack for single line code.\
if you don't have the file yet, putting the file as one of your `$IRBRC`, `$XDG_CONFIG_HOME/irb/irbrc` or `$HOME/.irbrc`

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

## References

- [power-assert-js/power-assert](https://github.com/power-assert-js/power-assert)
- [Power Assert in Ruby](https://speakerdeck.com/k_tsj/power-assert-in-ruby)
- [ja - IRB is new than Pry](https://k0kubun.hatenablog.com/entry/2021/04/02/211455)
