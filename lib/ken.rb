require 'pathname'
require 'rubygems'
require 'net/http'
require 'json'
require 'extlib'
require 'addressable/uri'

dir = Pathname(__FILE__).dirname.expand_path + 'ken'

require dir + 'version'
require dir + 'util'
require dir + 'resource'
require dir + 'type'
require dir + 'view'
require dir + 'property'
require dir + 'attribute'
require dir + 'collection'
require dir + 'session'
require dir + 'logger'

# init logger as soon as the library is required
Ken::Logger.new(STDOUT, :error)

# init default session
Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')

module Ken
  
  # Executes an Mql Query against the Freebase API and returns the result as
  # a <tt>Collection</tt> of <tt>Resources</tt>.
  #
  # == Examples
  #
  # Ken.all(:name => "Apple", :type => "/music/album")
  #
  # Ken.all(
  #  :directed_by => "George Lucas",
  #  :starring => [{
  #    :actor => "Harrison Ford"
  #  }],
  #  :type => "/film/film"
  # )
  # @api public
  def self.all(options = {})
    raise ArgumentError.new("must be a hash") unless options.is_a?(::Hash)
    query = {
      :id => nil,
      :name => nil
    }.merge(options)
    
    result = Ken.session.mqlread([query])    
    return Ken::Collection.new(result.map {|r| Ken::Resource.new(r)})
  end
  
  
  # Executes an Mql Query against the Freebase API and returns the result wrapped
  # in a <tt>Resource</tt> Object.
  #
  # == Examples
  #
  #  Ken.get('/en/the_police') => #<Resource id="/en/the_police" name="The Police">
  # @api public
  def self.get(id)
    # TODO check if it has a correct /type/object/id syntax
    raise ArgumentError.new("must be a string") unless id.is_a?(::String)
    
    query = {
      :id => id,
      :name => nil,
      :"ken:type" => [{
        :id => nil,
        :name => nil,
        :properties => [{
          :id => nil,
          :name => nil,
          :expected_type => nil,
          :unique => nil,
          :reverse_property => nil,
          :master_property => nil,
        }]
      }]
    }
    
    result = Ken.session.mqlread(query)
    return Ken::Resource.new(result)
  end
end # module Ken
