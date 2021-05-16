# coding: us-ascii
# frozen_string_literal: true
# Copyright (C) 2021 Kenichi Kamiya

require 'irb'

require_relative 'cmd/pa'

module IRB
  module ExtendCommandBundle
    def_extend_command(:irb_pa, :Pa, "#{__dir__}/cmd/pa.rb", [:pa, NO_OVERRIDE])
  end
end
