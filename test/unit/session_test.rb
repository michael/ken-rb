require 'test_helper'

class SessionTest < Test::Unit::TestCase
  context "A Session instance" do
    setup do
      Ken::Logger.new(STDOUT, :info)
      Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
    end
    
    should 'return the correct set of types' do
      result = Ken.session.mqlread({:id => "/en/the_police", :type => []})
      result['type'].length.should >= 1
    end
    
    should 'raise a Ken::MqlReadError if node does not exist' do
      lambda { Ken.session.mqlread({:id => "/en/the_police", :evil_property => []}) }.should raise_error(Ken::ReadError)
    end
    
    should 'do uncursored queries' do
      Ken.session.mqlread([{:type => '/chemistry/chemical_element'}]).length == 100
    end
    
    should 'do cursored queries' do
      Ken.session.mqlread([{:type => '/chemistry/chemical_element'}], :cursor => true).length.should >= 117
    end

    should 'do raw content requests' do
      Ken.session.raw_content("/guid/9202a8c04000641f800000000002c4f3").length.should >= 50
    end
    
    should 'do blurb content requests' do
      Ken.session.blurb_content("/guid/9202a8c04000641f800000000002c4f3", :maxlength => 200).length.should >= 50
    end
  end # context
end # SessionTest