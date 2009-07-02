require 'test_helper'

class PropertyTest < Test::Unit::TestCase
  context "A Property instance" do
    setup do
      data = load_fixture('music_artist')
      @type = Ken::Type.new(data)
      @value_property = @type.properties[1]
      @object_property = @type.properties[3]
    end
    
    should 'be a valid property instance' do
      @value_property.should be_kind_of(Ken::Property)
      @object_property.should be_kind_of(Ken::Property)
    end
  
    should 'have a type' do
      @value_property.type.should be_kind_of(Ken::Type)
      @object_property.type.should be_kind_of(Ken::Type)
    end
  
    should 'distinguish wheter it is an object or value type' do
      @value_property.object_type?.should == false
      @object_property.object_type?.should == true
    end
  end # context
end # PropertyTest