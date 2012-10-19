require 'area_cn/areas' 
require 'area_cn/version'
require 'active_support/core_ext/string/inflections'

module AreaCN
  class << self
    def areas
      @areas ||= Areas.instance
    end

    def find_all_by_name(name, area_level = nil)
      areas.find_all_by_name(name, area_level)
    end

    def find_by_name(name, area_level = nil)
      areas.find_by_name(name, area_level)    
    end

    def find_by_code(code, area_level = nil)
      areas.find_by_code(code, area_level)
    end

    def match(name, area_level = nil)
      areas.mathc(name, area_level)
    end
  end
end
