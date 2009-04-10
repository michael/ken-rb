module Ken
  class Property
    
    # initializes a resource by json result
    def initialize(data, type)
      raise "error" unless data.kind_of?(Hash)
      @data = data
      @type = type
      self
    end
    
    # @api public
    def id
      @data["id"]
    end
    
    # @api public
    def name
      @data["name"]
    end
    
    # @api public
    def to_s
      name || id || ""
    end
    
    # @api public
    def inspect
      result = "#<Property id=\"#{id}\" expected_type=\"#{expected_type || "nil"}\" unique=\"#{unique?}\" object_type=\"#{object_type?}\">"
    end
    
    # returns the type of which the property is a part of
    # every property always has exactly one type.
    # that's why /type/property/schema is a unique property
    # @api public
    def type
      @type
    end
    
    # @api public
    def reverse_property
      @data["reverse_property"]
    end
    
    # @api public
    def master_property
      @data["master_property"]
    end
    
    # returns true if the property is unique
    # @api public
    def unique?
      return @data["unique"]==true
    end
    
    # returns true if the property is an object type
    # @api public
    def object_type?
      !%w{
         /type/id
         /type/int
         /type/float
         /type/boolean
         /type/text
         /type/rawstring
         /type/uri
         /type/datetime
         /type/key
        }.include?(expected_type)
    end
    
    # returns true if the property is a value type
    # @api public
    def value_type?
      !object_type?
    end
    
    # @api public
    def expected_type
      @data["expected_type"]
    end
  end
end