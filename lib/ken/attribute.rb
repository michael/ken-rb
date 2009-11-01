module Ken
  class Attribute
    include Extlib::Assertions
    attr_reader :property
    
    # initializes a resource by json result
    def initialize(data, property)
      assert_kind_of 'data', data, Array
      assert_kind_of 'property', property, Ken::Property
      @data, @property = data, property
    end
    
    # factory method for creating an attribute instance
    # @api semipublic
    def self.create(data, property)
      Ken::Attribute.new(data, property)
    end
    
    # @api public
    def to_s
      subject.to_s
    end
    
    # @api public
    def inspect
      result = "#<Attribute property=\"#{property.id || "nil"}\">"
    end
    
    # returns a collection of values
    # in case of a unique property the array holds just one value
    # @api public
    def values
      subject
    end
    
    # unique properties can have at least one value
    # @api public
    def unique?
      @property.unique?
    end
    
    # object type properties always link to resources
    # @api public
    def object_type?
      @property.object_type?
    end
    
    # returns true if the property is a value type
    # value type properties refer to simple values like /type/text
    # @api public
    def value_type?
      @property.value_type?
    end
    
    # type, which attribute values of that property are expected to have
    # @api public
    def expected_type
      @property.expected_type
    end
    
    private
    # initializes the subject if used for the first time
    def subject
      @subject ||= Ken::Collection.new(@data.map { |r| object_type? ? Ken::Resource.new(r) : r["value"] })
    end
  end
end