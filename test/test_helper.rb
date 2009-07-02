require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'pathname'
require 'json'

gem 'jnunemaker-matchy', '0.4.0'
require 'matchy'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

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

class Test::Unit::TestCase
  # custom_matcher :be_nil do |receiver, matcher, args|
  #   matcher.positive_failure_message = "Expected #{receiver} to be nil but it wasn't"
  #   matcher.negative_failure_message = "Expected #{receiver} not to be nil but it was"
  #   receiver.nil?
  # end
  
  custom_matcher :have do |receiver, matcher, args|
    count = args[0]
    something = matcher.chained_messages[0].name
    actual = receiver.send(something).size
    actual == count
  end
  
  custom_matcher :be_true do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be true but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be true but it was"
    receiver.eql?(true)
  end
  
  custom_matcher :be_false do |receiver, matcher, args|
    matcher.positive_failure_message = "Expected #{receiver} to be false but it wasn't"
    matcher.negative_failure_message = "Expected #{receiver} not to be false but it was"
    receiver.eql?(false)
  end
 
end