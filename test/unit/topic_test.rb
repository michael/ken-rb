require 'test_helper'

class TopicTest < Test::Unit::TestCase
  context "A Topic instance" do
    setup do
      data = load_fixture('the_police_topic')
      @the_police = Ken::Topic.new(data)
    end
    
    should "have an id" do
      @the_police.id.should == "/en/the_police"
    end
    
    should "have aliases" do
      @the_police.aliases.length.should >= 1
    end
    
    should "have a text/name" do
      @the_police.text.should == "The Police"
      @the_police.name.should == "The Police"
    end
    
    should "have a thumbnail" do
      @the_police.thumbnail.should == "http://api.freebase.com/api/trans/image_thumb/en/the_police"
    end
    
    should "have webpages" do
      @the_police.webpages.length.should == 5
    end
    
    should "have types" do
      @the_police.types.length.should == 7
      @the_police.types.first.should be_kind_of(Ken::Type)
    end
    
    should "have properties" do
      @the_police.properties.length.should >= 1
      @the_police.properties.first.should be_kind_of(Ken::Property)      
    end
    
    should "have attributes" do
      @the_police.attributes.first.should be_kind_of(Ken::Attribute)
      
      # TODO support mediator properties (CVT's)
      # @the_police.attributes.length.should == @the_police.properties.length
    end
    
    should "have views" do
      @the_police.should have(7).views
      @the_police.views.first.should be_kind_of(Ken::View)
      @the_police.views.first.type.should be_kind_of(Ken::Type)
    end
    
    should "return individual view based requested type id" do
      @the_police.view('/music/artist').should be_kind_of(Ken::View)
      @the_police.view('/music/artist').attributes.length.should == 9
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
end # TopicTest