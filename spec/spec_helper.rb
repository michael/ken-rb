require 'pathname'
require 'rubygems'
require 'spec'
require 'json'

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path
require SPEC_ROOT.parent + 'lib/ken'

def load_fixture(fixture_name)
  fname = "#{File.dirname(__FILE__)}/fixtures/#{fixture_name}.json"
  unless File.exists?(fname)
    open(fname, "w") do |file|
      puts "WARNING: Fixtures could not be loaded."
    end
  end
  JSON.parse open(fname,"r").read
end

# this will append a <br /> to every logged message, which produces
# nicely formatted DataMapper debug outputs in Textmate's RSpec Bundle's output
module Ken
  class Logger
    def prep_msg(message, level)
      level << delimiter << message << "<br/>"
    end
  end
end

# debugging helper (textmate rspec bundle)
# TODO remove before release
ESCAPE_TABLE = { '&'=>'&amp;', '<'=>'&lt;', '>'=>'&gt;', '"'=>'&quot;', "'"=>'&#039;', }
def h(value)
 value.to_s.gsub(/[&<>"]/) {|s| ESCAPE_TABLE[s] }
end

Spec::Runner.configure do |config|
  config.after(:all) do
    
  end
end
