require 'pathname'
require 'rubygems'
require 'net/http'
require 'json'
require 'extlib/assertions'
require 'addressable/uri'

dir = Pathname(__FILE__).dirname.expand_path + 'ken'

require dir + 'util'
require dir + 'session'
require dir + 'resource'
require dir + 'type'
require dir + 'view'
require dir + 'property'
require dir + 'attribute'
require dir + 'collection'
require dir + 'topic'
require dir + 'logger'

# init logger as soon as the library is required
Ken::Logger.new(STDOUT, :error)

# init default session
Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')

module Ken
  extend Extlib::Assertions
  
  # store query as a constant here.
  # if the hash gets updated using
  # #merge! or #update, this will mean
  # that it actually stores the last
  # query used. there are 2 sides to this.
  # on the one hand, it isn't really a 
  # constant anymore (ruby doesn't complain)?
  # on the other hand, there is no need to
  # create a new object everytime a query is
  # executed. maybe this is fine, maybe not,
  # this needs to be discussed.
  
  FETCH_DATA_QUERY = {
    # :id => id, # needs to be merge!d in instance method
    :guid => nil,
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
    }],
    :"/type/reflect/any_master" => [
      {
        :id => nil,
        :link => nil,
        :name => nil,
        :optional => true,
        :limit => 999999
      }
    ],
    :"/type/reflect/any_reverse" => [
      {
        :id => nil,
        :link => nil,
        :name => nil,
        :optional => true,
        :limit => 999999
      }
    ],
    :"/type/reflect/any_value" => [
      {
        :link => nil,
        :value => nil,
        :optional => true,
        :limit => 999999
        # TODO: support multiple language
        # :lang => "/lang/en",
        # :type => "/type/text"
      }
    ]
  }
  
  # Executes an Mql Query against the Freebase API and returns the result as
  # a <tt>Collection</tt> of <tt>Resources</tt>.
  #
  # performs a cursored query unless there's a limit specified
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
    assert_kind_of 'options', options, Hash
    query = { :name => nil }.merge!(options).merge!(:id => nil)
    result = Ken.session.mqlread([ query ], :cursor => !options[:limit])    
    Ken::Collection.new(result.map { |r| Ken::Resource.new(r) })
  end
  
  
  # Executes an Mql Query against the Freebase API and returns the result wrapped
  # in a <tt>Resource</tt> Object.
  #
  # == Examples
  #
  #  Ken.get('/en/the_police') => #<Resource id="/en/the_police" name="The Police">
  # @api public
  def self.get(id)
    Ken::Resource.get(id)
  end
  
end # module Ken
