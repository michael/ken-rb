require 'pathname'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Ken::Resource do
  
  before :each do
    # Ken::Logger.new(STDOUT, :info)
    # Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
    data = load_fixture('the_police')
    @the_police = Ken::Resource.new(data)
  end
  
  it 'should have types' do
    @the_police.types.should have_at_least(1).items
    @the_police.types.first.should be_kind_of(Ken::Type)
  end
  
  it 'should have views' do
    @the_police.views.should have(6).items
    @the_police.views.first.should be_kind_of(Ken::View)
    @the_police.views.first.type.should be_kind_of(Ken::Type)
  end
  
  it 'should have an id and a name' do
    @the_police.id.should be_kind_of(::String)
    @the_police.name.should be_kind_of(::String)
  end
  
  it 'should have attributes' do
    @the_police.attributes.should_not be_nil
  end
  
  it 'should deal with non-unique value type attributes' do
    pending
  end
  
  it 'should deal with unique object type attributes' do
    pending
  end
  
  it 'should deal with non-unique object type attributes' do
    pending
  end
  
  it 'should load attributes only on demand' do
    @the_police.attributes_loaded?.should == false
    @the_police.attributes
    @the_police.attributes_loaded?.should == true
  end
  
  it 'should load schema only on demand when calling types' do
    @the_police.schema_loaded?.should == false
    @the_police.types
    @the_police.schema_loaded?.should == true
  end
  
  it 'should load schema only on demand when calling views' do
    @the_police.schema_loaded?.should == false
    @the_police.views
    @the_police.schema_loaded?.should == true
  end
end