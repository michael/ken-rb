require 'test_helper'

class TypeTest < Test::Unit::TestCase
  context "A Session instance" do
    setup do
      data = load_fixture('the_police')
      @type = Ken::Resource.new(data).types.first
    end
  
    should 'have an id and a name' do
      @type.id.should be_kind_of(String)
      @type.name.should be_kind_of(String)
    end

    should 'have properties' do
      @type.should have(16).properties
    end
    
    context "when accessing a property directly" do
      setup do
        @genre = @type.genre
        @album = @type.album
      end
      
      should "be kind of Ken::Property" do
        @genre.should be_kind_of(Ken::Property)
        @album.should be_kind_of(Ken::Property)
      end
      
      should "raise AttributeNotFound when invalid propertyname is supplied" do
        lambda { @type.not_existing_property }.should raise_error(Ken::PropertyNotFound)
      end
    end # context
  end # context
end # TypeTest