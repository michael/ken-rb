require 'pathname'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Ken::Attribute do
  before :all do
    Ken::Logger.new(STDOUT, :info)
    Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
    data = load_fixture('the_police')
    @the_police = Ken::Resource.new(data)
    
    @attribute = @unique_value_attribute = @the_police.attributes[2] # /music/artist/active_start
    @unique_object_attribute = @the_police.attributes[11] # /music/artist/origin
    @non_unique_value_attribute = @the_police.attributes[8] # /common/topic/alias
    @non_unique_object_attribute = @the_police.attributes[4] # /music/artist/album
  end
  
  it "should have values" do
    @attribute.values.should_not be_nil
  end
  
  describe "with unique value type" do
    it "should be unique and no object_type" do
      @unique_value_attribute.unique?.should == true
      @unique_value_attribute.object_type?.should == false
    end
  end
  
  describe "with unique object type" do
    it "be unique and an object type" do
      @unique_object_attribute.unique?.should == true
      @unique_object_attribute.object_type?.should == true
    end
  end
  
  describe "with non-unique value type" do
    it "be unique and an object type" do
      @non_unique_value_attribute.unique?.should == false
      @non_unique_value_attribute.object_type?.should == false
    end
  end
  
  describe "with non-unique object type" do
    it "be unique and an object type" do
      @non_unique_object_attribute.unique?.should == false
      @non_unique_object_attribute.object_type?.should == true
    end
  end
end

