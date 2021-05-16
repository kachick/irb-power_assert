# irb-power_assert

![Build Status](https://github.com/kachick/irb-power_assert/actions/workflows/test.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/irb-power_assert.png)](http://badge.fury.io/rb/irb-power_assert)

## Overview

![screenshot](https://user-images.githubusercontent.com/1180335/118403880-772c8000-b6ab-11eb-9469-c27aa0b67db8.png)

[ruby/power_assert](https://github.com/ruby/power_assert) is a recent My favorites. (the author is [@k-tsj](https://github.com/k-tsj), thank you!)

It is super helpful in complex testing.

Don't say [ruby/irb](https://github.com/ruby/irb) is old-fashioned.

I just would get irb version of [yui-knk/pry-power_assert](https://github.com/yui-knk/pry-power_assert)

Honor should be bestowed upon them.

## Usage

Require Ruby 2.5 or later

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

Or

```ruby
require 'irb-power_assert'
```

```console
$ irb
# Then enabled this gem!
```

The you can use `pa` as an IRB command.

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

## References

* [power-assert-js/power-assert](https://github.com/power-assert-js/power-assert)
* [Power Assert in Ruby](https://speakerdeck.com/k_tsj/power-assert-in-ruby)
* [ja - IRB is new than Pry](https://k0kubun.hatenablog.com/entry/2021/04/02/211455)
