require 'pathname'

require Pathname(__FILE__).dirname.expand_path + 'spec_helper'

describe Ken do
  before :all do
    # Ken::Logger.new(STDOUT, :info)
    Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
  end
  
  it 'should return a Ken::Resource' do
    the_police = Ken.get("/en/the_police")
    the_police.should be_kind_of(Ken::Resource)
  end
  
end
