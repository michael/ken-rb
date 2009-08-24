require 'pathname'
require 'rubygems'

# displays all links related to music/artists
# low level api through Ken.session.mqlread is used here

EXAMPLES_ROOT = Pathname(__FILE__).dirname.expand_path
require EXAMPLES_ROOT.parent + 'lib/ken'

Ken::Session.new('http://www.freebase.com', 'ma', '*****')

puts "collecting artist links... this might take a while..."

artist_links = []

# execute query
artists = Ken.session.mqlread([{
  :type => "/music/artist",
  :id => nil, 
  :"/common/topic/webpage" => [{:uri => nil}], 
  :home_page => [{:uri => nil}]
}], :cursor => true)

# collect artist links
artists.each do |artist|
  artist["/common/topic/webpage"].each do |webpage|
    artist_links << webpage["uri"] unless artist_links.include?(webpage["uri"])
  end
  
  artist["home_page"].each do |homepage|
    artist_links << homepage["uri"] unless artist_links.include?(homepage["uri"])
  end
end

# print artist links
artist_links.each do |link|
  puts link
end