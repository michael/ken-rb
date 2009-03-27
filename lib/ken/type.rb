module Ken
  class Type
    
    # initializes a resource by json result
    def initialize(data)
      raise "error" unless data.kind_of?(Hash)
      
      @data = data
      self
    end
    
    # access property info
    def properties
      Ken::Collection.new(@data["properties"].map { |property| Ken::Property.new(property, self) })
    end
    
    def id
      @data["id"]
    end

    def name
      @data["name"]
    end
  end
end