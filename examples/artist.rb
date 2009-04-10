require 'pathname'
require 'rubygems'

EXAMPLES_ROOT = Pathname(__FILE__).dirname.expand_path
require EXAMPLES_ROOT.parent + 'lib/ken'

Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')

resource = Ken.get('/en/the_police')

resource.views.each do |view|
  puts view
  puts "==============================="
  view.attributes.each do |a|
    puts a.property
    puts "----------------"
    puts a
    puts # newline
  end
end