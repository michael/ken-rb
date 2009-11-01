module Ken
  class Topic
    include Extlib::Assertions
    extend Extlib::Assertions
    
    attr_reader :data
    
    # initializes a topic using a json result
    def initialize(data)
      assert_kind_of 'data', data, Hash
      @data = data
      @schema_loaded, @attributes_loaded = false, false
    end
    
    # Retrieves a topic using the Topic API by Freebase
    # returns a <tt>Topic</tt> Object.
    #
    # == Examples
    #
    #  Ken::Topic.get('/en/the_police') => #<Topic id="/en/the_police" name="The Police">
    # @api public
    def self.get(id)
      assert_kind_of 'id', id, String
      result = Ken.session.topic(id)
      raise TopicNotFound unless result
      Ken::Topic.new(result)
    end
    
    # topic id
    # @api public
    def id
      @data["id"] || ""
    end
    
    # topic aliases
    def aliases
      @data["alias"]
    end
    
    # topic freebase url
    def url
      @data["url"]
    end
    
    # topic name
    # @api public
    def name
      text
    end
    
    # topic description
    # @api public
    def description
      @data["description"]
    end
    
    # topic text
    # @api public
    def text
      @data["text"]
    end
    
    # topic thumbnail
    def thumbnail
      @data["thumbnail"]
    end
    
    # @api public
    def to_s
      name || id || ""
    end

    # @api public
    def inspect
      result = "#<Topic id=\"#{id}\" name=\"#{name || "nil"}\">"
    end
    
    # topic webpages
    # currently returned as an array of hashes containing the keys "text" and "url"
    # that hashes may be wrapped into a Webpage class later
    # @api public
    def webpages
      @data["webpage"]
    end
    
    # returns all assigned types
    # @api public
    def types
      load_schema! unless schema_loaded?
      @types
    end
    
    # returns individual type based on the requested type id
    # @api public
    def type(type)
      types.each { |t| return t if t.id =~ /^#{Regexp.escape(type)}$/}
      nil
    end
    
    # returns all the properties from all assigned types
    # @api public
    def properties
      @properties = Ken::Collection.new
      types.each do |type|
        @properties.concat(type.properties)
      end
      @properties
    end
    
    # returns all attributes for every type the topic is an instance of
    # @api public
    def attributes
      load_attributes! unless attributes_loaded?
      @attributes.values
    end 
    
    # returns all available views based on the assigned types
    # @api public
    def views
      @views ||= Ken::Collection.new(types.map { |type| Ken::View.new(self, type) })
    end
    
    # returns individual view based on the requested type id
    # @api public
    def view(type)
      views.each { |v| return v if v.type.id =~ /^#{Regexp.escape(type)}$/}
      nil
    end
    
    
    # search for an attribute by name and return it
    # @api public
    def attribute(name)
      attributes.each { |a| return a if a.property.id == name }
      nil
    end
    
    # returns true if type information is already loaded
    # @api public
    def schema_loaded?
      @schema_loaded
    end
    
    # returns true if attributes are already loaded
    # @api public
    def attributes_loaded?
      @attributes_loaded
    end
    
    private
    
    # loads the full set of attributes using reflection
    # information is extracted from master, value and reverse attributes
    # @api private
    def load_attributes!
      load_schema! unless schema_loaded?
      
      @attributes = {}
      @data["properties"].each do |id, data|
        # skip mediator properties for now
        if !data["properties"]
          values = []
          data["values"].each do |value|
            values << { "id" => value["id"], "name" => value["text"], "value" => value["text"] }
          end
          @attributes[id] = Ken::Attribute.create(values, properties.select { |p| p.id == id }.first)
        end
      end
      
      @attributes_loaded = true
    end
    
    # loads the topic's metainfo
    # @api private
    def load_schema!
      result = {}
      
      @data["type"].each do |type|
        result[type["id"]] = { "id" => type["id"], "name" => type["text"], "properties" => [] }
      end
      @data["properties"].each do |id, data|        
        result[id.gsub(/\/\w*$/, "")]["properties"] << {
          "expected_type" => data["expected_type"]["id"],
          "id" => id,
          "name" => data["text"],
          "unique" => true 
        }
      end
      @types = Ken::Collection.new(result.values.map { |type| Ken::Type.new(type) })
      @schema_loaded = true
    end
    
  end # class Topic
end # module Ken