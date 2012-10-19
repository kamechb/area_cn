module AreaCN
  class Code
    include Comparable

    ROOT = "000000"

    attr_accessor :code

    def initialize(code)
      @code = code
    end

    def value
      code
    end

    def prefix
      return if code == ROOT
      return @prefix if @prefix
      code_prefix = code.sub(/0{2,4}$/, '') 
      code_prefix << '0' if code_prefix.length.odd?
       
      code_prefix 
    end

    def parent
      return if @code == ROOT
      @parent ||= Code.new(prefix.sub(/..$/, '00').ljust(6, '0'))
    end

    def ancestors
      return @ancestors if @ancestors
      child = self
      ancestors = [self] 
      ancestors << child while child = child.parent 
            
      ancestors
    end

    def ancestor?(other)
      other = Code.new(other) unless other.is_a?(Code)
      other.ancestors.include?(self)
    end

    def child?(other)
      other = Code.new(other) unless other.is_a?(Code)
      other.ancestor?(self)
    end

    def <=>(other)
      self.code <=> other.code
    end

    def inspect
      @code
    end

    def to_s
      @code
    end
  end
end
