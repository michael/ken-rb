# provides an interface to view a resource as a specific type
# provides an interface for working with attributes, properties
module Ken
  class View
    
    include Extlib::Assertions
    
    # initializes a resource by json result
    def initialize(resource, type)
      assert_kind_of 'resource', resource, Ken::Resource
      assert_kind_of 'type', type, Ken::Type
      @resource, @type = resource, type
    end
    
    # @api public
    def to_s
      @type.to_s
    end
    
    # return correspondent type
    # @api public
    def type
      @type
    end
    
    # @api public
    def inspect
      result = "#<View type=\"#{type.id || "nil"}\">"
    end
    
    # returns attributes which are member of the view's type
    # @api public
    def attributes
      @resource.attributes.select { |a| a.property.type == @type}
    end
    
    # search for an attribute by name and return it
    # @api public
    def attribute(name)
      attributes.each { |a| return a if a.property.id =~ /\/#{name}$/ }
      raise AttributeNotFound
    end
    
    # returns properties which are member of the view's type    
    # @api public
    def properties
      @resource.properties.select { |p| p.type == @type}
    end
    
    # delegate to attribute
    def method_missing sym
      attribute(sym.to_s)
    end
    
  end
end