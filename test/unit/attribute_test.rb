require 'test_helper'

class AttributeTest < Test::Unit::TestCase
  context "An Attribute instance" do
    setup do
      data = load_fixture('the_police')
      @the_police = Ken::Resource.new(data)

      @attribute = @unique_value_attribute = @the_police.attributes[2] # /music/artist/active_start
      @unique_object_attribute = @the_police.attributes[12] # /music/artist/origin
      @non_unique_value_attribute = @the_police.attributes[9] # /common/topic/alias
      @non_unique_object_attribute = @the_police.attributes[5] # /music/artist/album
    end
  
    should "should have values" do
      @attribute.should have(1).values
      @non_unique_object_attribute.should have(14).values
    end

    context "with unique value type" do
      should "be unique and no object_type" do
        @unique_value_attribute.unique?.should == true
        @unique_value_attribute.object_type?.should == false
      end
    end
    
    context "with unique object type" do
      should "be unique and an object type" do
        @unique_object_attribute.unique?.should == true
        @unique_object_attribute.object_type?.should == true
      end
    end
    
    context "with non-unique value type" do
      should "not be unique and not an object type" do
        @non_unique_value_attribute.unique?.should == false
        @non_unique_value_attribute.object_type?.should == false
      end
    end
    
    context "with non-unique object type" do
      should "be unique and an object type" do
        @non_unique_object_attribute.unique?.should == false
        @non_unique_object_attribute.object_type?.should == true
      end
    end
  end # context
end # AttributeTest