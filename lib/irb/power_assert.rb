# coding: us-ascii
# frozen_string_literal: true
# Copyright (C) 2021 Kenichi Kamiya

require 'irb'
require 'power_assert'

module IRB
  module PowerAssert
    def self.newer_irb?
      # This assumes irb bumps minor or major in next versions, because they do not bump in current development versions.
      Gem::Version.create(IRB::VERSION) >= Gem::Version.create('1.13.0') || RUBY_VERSION >= '3.4'
    end
  end
end

module PowerAssert
  INTERNAL_LIB_DIRS[IRB::PowerAssert] = File.dirname(File.dirname(caller_locations(1, 1).first.path))
end

require_relative 'power_assert/version'
require_relative 'cmd/pa'
