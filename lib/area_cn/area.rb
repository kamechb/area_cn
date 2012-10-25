require 'area_cn/code'

module AreaCN
  class Area
    include Comparable

    attr_reader :name, :code, :children
    attr_accessor :parent

    # area is a json area from areas.json file
    def initialize(area = {})
      @name = area["text"]
      @code = Code.new(area["id"])
      @children = []
    end

    def parent_code
      @code.parent
    end

    def children_names
      @children_names ||= children.map(&:name)
    end

    def children_codes
      @children_codes ||= children.map(&:code)
    end

    def province?
      @code.prefix.length == 2
    end

    def city?
      @code.prefix.length == 4
    end

    def district?
      @code.prefix.length == 6
    end

    def <=>(other)
      code <=> other.code
    end

    def to_hash
      {name: name, code: code}
    end

    def to_json(*args)
      to_hash.to_json(*args)
    end

    def inspect
      to_hash
    end
  end

  class Province < Area
    alias_method :cities, :children

    def ancestors
      [self]
    end
  end

  class City < Area
    alias_method :districts, :children
    alias_method :province,  :parent
    alias_method :province=, :parent=


    alias_method :province_code, :parent_code

    def ancestors
      [self, parent]
    end
  end

  class District < Area
    alias_method :city,  :parent
    alias_method :city=, :parent=

    alias_method :city_code, :parent_code

    def ancestors
      [self, parent, parent.parent]
    end
  end
end
