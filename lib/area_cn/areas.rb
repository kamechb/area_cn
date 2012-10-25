require 'area_cn/area'
require 'json'
require 'singleton'

module AreaCN
  class Areas
    include Singleton
    attr_reader :provinces, :cities, :districts, :all

    def initialize
      @provinces = json_data['province'].map { |area_attr| Province.new(area_attr) }
      @cities    = json_data['city'].map { |area_attr| City.new(area_attr) }
      @districts = json_data['district'].map { |area_attr| District.new(area_attr) }

      @all = @provinces + @cities + @districts

      locate_areas
    end

    def find_all_by_name(name, area_level = nil)
      scope = area_level ? instance_variable_get("@#{area_level.to_s.pluralize}") : all
      scope.select { |area| area.name == name }
    end

    def find_by_name(name, area_level = nil)
      scope = area_level ? instance_variable_get("@#{area_level.to_s.pluralize}") : all
      scope.detect { |area| area.name == name }
    end

    def find_by_code(code, area_level = nil)
      scope = area_level ? instance_variable_get("@#{area_level.to_s.pluralize}") : all
      scope.detect { |area| area.code == code }
    end
    alias_method :get, :find_by_code

    def match(name, area_level = nil)
      scope = area_level ? instance_variable_get("@#{area_level.to_s.pluralize}") : all
      scope.select { |area| area.name =~ /^#{name}/ }
    end

    private
    def json_data(file = File.expand_path("../../data/areas.json", __FILE__))
      @json_data ||= JSON.parse(File.read(file))
    end

    def locate_areas
      @cities.each do |city|
        province = @provinces.detect { |p| p.code == city.province_code  }
        city.province = province
        province.children << city
      end

      @districts.each do |district|
        city = @cities.detect { |c| c.code == district.city_code }
        district.city = city
        city.children << district
      end
    end
  end
end
