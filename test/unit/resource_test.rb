require 'test_helper'

class ResourceTest < Test::Unit::TestCase
  context "A Resource instance" do
    setup do
      data = load_fixture('the_police')
      @the_police = Ken::Resource.new(data)
    end
  
    should "have types" do
      @the_police.should have(6).types
      @the_police.types.first.should be_kind_of(Ken::Type)
    end
    
    should "have views" do
      @the_police.should have(6).views
      @the_police.views.first.should be_kind_of(Ken::View)
      @the_police.views.first.type.should be_kind_of(Ken::Type)
    end
    
    should "return individual view based requested type id" do
      @the_police.view('/music/artist').should be_kind_of(Ken::View)
      @the_police.view('/location/location').should be_nil # not existent view
    end
    
    should "return individual type based requested type id" do
      @the_police.type('/music/artist').should be_kind_of(Ken::Type)
      @the_police.type('/location/location').should be_nil # not existent type
    end
    
    should 'have a full set of attributes' do
      @the_police.attributes.should_not be_nil
    end
    
    should "have id and name properties" do
      @the_police.id.should be_kind_of(String)
      @the_police.name.should be_kind_of(String)
    end
    
    should 'load attributes only on demand' do
      @the_police.attributes_loaded?.should == false
      @the_police.attributes
      @the_police.attributes_loaded?.should == true
    end
    
    should 'load schema only on demand when calling types' do
      @the_police.schema_loaded?.should == false
      @the_police.types
      @the_police.schema_loaded?.should == true
    end

    should 'load schema only on demand when calling views' do
      @the_police.schema_loaded?.should == false
      @the_police.views
      @the_police.schema_loaded?.should == true
    end
  end # context
end # ResourceTest