module Ken
  class Attribute
    attr_reader :property
    
    # initializes a resource by json result
    def initialize(data, property)
      assert_kind_of 'data', data, Array
      @data = data
      @property = property # belongs to a property
      self
    end
    
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
    
    # returns just the subject
    def values
      subject
    end
    
    def unique?
      @property.unique?
    end
    
    def object_type?
      @property.object_type?
    end
    
    # is this a good idea? using the values method seems more natural to me
    # def method_missing(name, *args, &block)
    #   subject.send(name, *args, &block)
    # end
    
    # initializes the subject if used the first time
    private
    def subject
      @subject ||= Ken::Collection.new(@data.map { |r| object_type? ? Ken::Resource.new(r) : r["value"] })
    end
  end
end