#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "yazawa"

class String
  # For example
  #
  #   require "yazawa/ize"
  #   
  #   p '俺達の熱意で世界が変わる'.to_yazawa # => '俺達の『NETSUI』で世界が変わる'
  #   p '俺達の熱意で世界が変わる'.to_yazawa(at_random: true) # => '俺達の熱意で『SEKAI』が変わる'
  def to_yazawa(*options)
    YAZAWA.convert(self, *options)
  end
end
