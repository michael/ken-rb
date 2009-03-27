module Ken
  class Resource
    # initializes a resource by json result
    def initialize(data)
      return nil unless data
      raise "error" unless data.kind_of?(Hash)

      @data = data
      self
    end
    
    # access type info
    # api public
    def types
      Ken::Collection.new(@data["type"].map { |type| Ken::Type.new(type) })
    end
    
    # api public
    def id
      @data["id"]
    end
    
    # api public
    def name
      @data["name"] if @data["name"]
    end
    
    # returns all the properties from all assigned types
    def properties
      @properties = Ken::Collection.new
      types.each do |type|
        @properties.concat(type.properties)
      end
      @properties
    end
    
    # eg. read_attribute("/music/artist/origin")
    # or the shurtcut version read_attribute("origin")
    # api public
    def read_attribute(attr_name)
      properties.each do |prop|
        if prop.id == attr_name || prop.id.split('/').last == attr_name
          # query the value
          query = {
            :id => id,
            prop.id.to_sym => nil
          }
          
          # fetch attribute
          result = Ken.session.mqlread(query)
          
          # TODO: return either a simple type ruby equivalent or an object type -> Ken::Resource
          return result[prop.id]
        else
          return nil
        end
      end # properties.each
    end # read_attrribute
  end # class Resource
end # module Ken