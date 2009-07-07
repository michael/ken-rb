require 'test_helper'

class KenTest < Test::Unit::TestCase
  context "Ken.get" do
    setup do
      Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
    end
  
    should 'return a Ken::Resource' do
      the_police = Ken.get("/en/the_police")
      the_police.should be_kind_of(Ken::Resource)
    end
    
    should 'raise a Ken::ResourceNotFound error if id does not exist' do
      lambda { Ken.get("/en/non_existent_resource") }.should raise_error(Ken::ResourceNotFound)
    end
  end
  
  context "Ken.all" do
    should "return a Ken::Collection of Ken::Resources" do
      resources = Ken.all(:name => "Apple")
      resources.should be_kind_of(Ken::Collection)
      resources.first.should be_kind_of(Ken::Resource)
    end
  
    should "work with a limit specified" do
      resources = Ken.all(:name => "Apple", :limit => 3)
      resources.length.should == 3
    end
    
    should "be able to return more than 100 resources (using cursored queries) " do
      Ken.all({:type => '/chemistry/chemical_element'}).length.should > 100
    end
    
    should "work with a type specified" do
      resources = Ken.all(:name => "Apple", :type => "/music/album")
      resources.length.should >= 1
      resources.each {|r| r.types.select {|t| t.id == "/music/album"}.length.should == 1 }
    end
      
    should "understand nested queries" do
      query = {
        :directed_by => "George Lucas",
        :starring => [
          {
            :actor => "Harrison Ford"
          }
        ],
        :type => "/film/film"
      }
    
      resources = Ken.all(query)
      resources.length.should == 3
      resources.first.name.should == "Star Wars Episode IV: A New Hope"
      resources.last.name.should == "The Star Wars Holiday Special"
    end
  end
  
  context "A Ken::Resource Instance" do
    setup do
      @the_police = Ken.get("/en/the_police")
    end
    
    should "provide attributes" do
      @the_police.attributes.length.should >= 1
      @the_police.attributes.first.should be_kind_of(Ken::Attribute)
    end
    
    should "have views" do
      @the_police.views.length.should >= 1
      @the_police.views.first.should be_kind_of(Ken::View)
      @the_police.views.first.type.should be_kind_of(Ken::Type)
    end
  end
end