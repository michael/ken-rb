# provides an interface to view a resource as a specific type
# provides an interface for working with attributes, properties
module Ken
  class View    
    # initializes a resource by json result
    def initialize(resource, type)
      raise "error" unless resource.kind_of?(Ken::Resource)
      raise "error" unless type.kind_of?(Ken::Type)
      
      @resource = resource # belongs to a resource
      @type = type # belongs to a type
      self
    end
    
    # @api public
    def to_s
      @type.to_s
    end
    
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
    
    # returns properties which are member of the view's type    
    # @api public
    def properties
      @resource.properties.select { |p| p.type == @type}
    end
    
  end
end