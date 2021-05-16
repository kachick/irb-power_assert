# coding: us-ascii
# frozen_string_literal: true
# Copyright (C) 2021 Kenichi Kamiya

require 'irb'
require 'power_assert'
require_relative 'cmd/pa'

module IRB
  module PowerAssert
  end

  module ExtendCommandBundle
    def_extend_command(:irb_pa, :Pa, "#{__dir__}/cmd/pa.rb", [:pa, NO_OVERRIDE])
  end
end

module PowerAssert
  INTERNAL_LIB_DIRS[IRB::PowerAssert] = File.dirname(File.dirname(caller_locations(1, 1).first.path))
end

require_relative 'power_assert/version'
