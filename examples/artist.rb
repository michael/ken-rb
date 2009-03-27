require 'pathname'
require 'rubygems'

EXAMPLES_ROOT = Pathname(__FILE__).dirname.expand_path
require EXAMPLES_ROOT.parent + 'lib/ken'

Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')

# fetch a resource

artist = Ken.get('/en/the_rolling_stones')

# let's inspect that resource
artist.types.each do |type|
  puts ""
  puts type.name
  puts "=================================================="
  type.properties.each do |prop|
    puts prop.name
    # soon you will also be able to fetch attribute values by simply calling
    # -> artist.read_attribute(prop.id)
    # or if you already know which attribute you want to fetch
    # -> artist.<attributename> e.g. artist.origin
  end
  puts
end

puts artist.read_attribute('origin')