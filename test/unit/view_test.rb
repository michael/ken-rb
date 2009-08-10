require 'test_helper'

class ViewTest < Test::Unit::TestCase
  context "A View instance" do
    setup do
      Ken::Logger.new(STDOUT, :info)
      data = load_fixture('the_police')
      @the_police = Ken::Resource.new(data)
      @view = @the_police.views.first
    end
  
    should "have a type" do
      @view.type.should_not be_nil
      @view.type.should be_kind_of(Ken::Type)
    end
    
    should "have properties" do
      @view.properties.should_not be_nil
      @view.properties.each { |p| p.should be_kind_of(Ken::Property)}
    end
    
    should "have attributes" do
      @view.attributes.should_not be_nil
      @view.attributes.each { |p| p.should be_kind_of(Ken::Attribute)}
    end
    
    context "when accessing a direct attribute" do
      setup do
        @genre = @view.attribute('genre')
        @album = @view.album
      end
      
      should "be kind of Ken::Attribute" do
        @genre.should be_kind_of(Ken::Attribute)
        @album.should be_kind_of(Ken::Attribute)
      end
      
      should "be able to get values" do
        @genre.should have(6).values
        @album.should have(14).values
      end
      
      should "raise AttributeNotFound when invalid propertyname is supplied" do
        @view.not_existing_attribute.should be_nil
      end
    end # context
  end # context
end # ViewTest