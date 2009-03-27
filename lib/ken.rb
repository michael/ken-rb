require 'pathname'
require 'rubygems'
require 'net/http'
require 'json'
require 'extlib'
require 'addressable/uri'

dir = Pathname(__FILE__).dirname.expand_path + 'ken'

require dir + 'version'
require dir + 'resource'
require dir + 'type'
require dir + 'property'
require dir + 'collection'
require dir + 'session'
require dir + 'logger'

# init logger as soon as the library is required
Ken::Logger.new(STDOUT, :error)


module Ken
  def self.all(options = {})
    #raise ArgumentError.new("must be a hash") unless options.is_a(::Hash)
    raise NotImplementedError
  end
  
  def self.get(id)
    # TODO check if it has a correct /type/object/id syntax
    raise ArgumentError.new("must be a string") unless id.is_a?(::String)
    
    query = {
      :id => id,
      :name => nil,
      :type => [{
        :id => nil,
        :name => nil,
        :properties => [{
          :id => nil,
          :name => nil,
          :expected_type => nil
        }]
      }]
    }
    
    result = Ken.session.mqlread(query)
    return Ken::Resource.new(result)
  end
end # module Ken
