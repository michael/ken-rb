module Ken
  class Property
    
    # initializes a resource by json result
    def initialize(data, type)
      raise "error" unless data.kind_of?(Hash)

      @data = data
      @type = type
      self
    end
    
    def id
      @data["id"]
    end

    def name
      @data["name"]
    end
    
    def type
      @type
    end
    
    def expected_type
      @data["expected_type"]
    end
  end
end