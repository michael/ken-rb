require 'pathname'
require 'rubygems'

# displays all links related to music/artists
# low level api through Ken.session.mqlread is used here

EXAMPLES_ROOT = Pathname(__FILE__).dirname.expand_path
require EXAMPLES_ROOT.parent + 'lib/ken'

Ken::Session.new('http://www.freebase.com', 'ma', '*****')

artists = Ken.session.mqlread([{
  :type => "/music/artist",
  :id => nil, 
  :"/common/topic/webpage" => [{:uri => nil}], 
  :home_page => [{:uri => nil}], 
  :limit => 50
}])

artists.each do |artist|
  artist["/common/topic/webpage"].each do |webpage|
    puts webpage["uri"]
  end
  
  artist["home_page"].each do |homepage|
    puts homepage["uri"]
  end
end