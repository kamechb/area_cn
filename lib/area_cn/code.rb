module AreaCN
  class Code < String
    ROOT = "000000"

    attr_reader :code

    def initialize(code)
      @code = code
      super(code)
    end

    def value
      code
    end

    def prefix
      return if code == ROOT
      return @prefix if @prefix
      @prefix = code.sub(/0{2,4}$/, '') 
      @prefix << '0' if @prefix.length.odd?
       
      @prefix 
    end

    def parent
      return if @code == ROOT
      @parent ||= Code.new(prefix.sub(/..$/, '00').ljust(6, '0'))
    end

    def ancestors
      return @ancestors if @ancestors
      child = self
      @ancestors = [self] 
      @ancestors << child while child = child.parent 
            
      @ancestors
    end

    def ancestor?(other)
      other = Code.new(other) unless other.is_a?(Code)
      other.ancestors.include?(self)
    end

    def child?(other)
      self.ancestors.include?(other)
    end
  end
end
