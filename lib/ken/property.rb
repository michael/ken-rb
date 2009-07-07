module Ken
  class Property
    
    include Extlib::Assertions
    
    VALUE_TYPES = %w{
     /type/id
     /type/int
     /type/float
     /type/boolean
     /type/text
     /type/rawstring
     /type/uri
     /type/datetime
     /type/key
    }
    
    # initializes a resource by json result
    def initialize(data, type)
      assert_kind_of 'data', data, Hash
      assert_kind_of 'type', type, Ken::Type
      @data, @type = data, type
    end
    
    # property id
    # @api public
    def id
      @data["id"]
    end
    
    # property name
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
    
    # reverse property, which represent incoming links
    # @api public
    def reverse_property
      @data["reverse_property"]
    end
    
    # master property, which represent an outgoing link (or primitive value)
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
      !value_type?
    end
    
    # returns true if the property is a value type
    # @api public
    def value_type?
      VALUE_TYPES.include?(expected_type)
    end
    
    # type, which attribute values of that property are expected to have
    # @api public
    def expected_type
      @data["expected_type"]
    end
  end
end