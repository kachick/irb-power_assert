# coding: us-ascii
# frozen_string_literal: true
# Copyright (C) 2021 Kenichi Kamiya

require 'irb'
require 'power_assert'
require_relative 'power_assert/version'

module PowerAssert
  INTERNAL_LIB_DIRS[IRB::PowerAssert] = File.dirname(File.dirname(caller_locations(1, 1).first.path))
end

require_relative 'cmd/pa'
