module Ken
  class Type
    
    include Extlib::Assertions
    
    # initializes a resource by json result
    def initialize(data)
      assert_kind_of 'data', data, Hash
      @data = data
    end
    
    # access property info
    # @api public
    def properties
      Ken::Collection.new(@data["properties"].map { |property| Ken::Property.new(property, self) })
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
      result = "#<Type id=\"#{id}\" name=\"#{name || "nil"}\">"
    end
  end
end