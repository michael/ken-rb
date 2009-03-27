require 'pathname'

require Pathname(__FILE__).dirname.expand_path + 'spec_helper'

describe Ken::Resource do
  before :all do
    Ken::Logger.new(STDOUT, :info)
    Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')

    # fetch a resource
    @the_police = Ken.get("/en/the_police")
  end
    
  it 'should have types' do
    @the_police.types.should have_at_least(1).items
    @the_police.types.first.should be_kind_of(Ken::Type)
  end
  
  it 'should have an id and a name' do
    @the_police.id.should be_kind_of(::String)
    @the_police.name.should be_kind_of(::String)
  end
  
  it 'should get known attributes' do
    # expected London
    @the_police.read_attribute('origin').should == "London"
  end
end