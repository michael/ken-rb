require 'pathname'

require Pathname(__FILE__).dirname.expand_path + 'spec_helper'

describe Ken::Session do

  before :all do
    Ken::Logger.new(STDOUT, :info)
    Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
  end
  
  it 'should return the types of the_police' do
    result = Ken.session.mqlread({:id => "/en/the_police", :type => []})
    result['type'].length.should == 6
  end
  
  it 'should raise an Ken::MqlReadError if node does not exist' do
    lambda { Ken.session.mqlread({:id => "/en/the_police", :evil_property => []}) }.should raise_error(Ken::ReadError)
  end
end