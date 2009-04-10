require 'pathname'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Ken do
  before :all do
    # Ken::Logger.new(STDOUT, :info)
    Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
  end
  
  describe "Ken.get('/en/the_police')" do
    it 'should return a Ken::Resource' do
      the_police = Ken.get("/en/the_police")
      the_police.should be_kind_of(Ken::Resource)
    end
  end
  
  describe "Ken::Resource" do
    before :all do
      @the_police = Ken.get("/en/the_police")
    end
    
    it "should provide attributes" do
      @the_police.attributes.should have_at_least(1).items
      @the_police.attributes.first.should be_kind_of(Ken::Attribute)
    end
    
    it "should have views" do
      @the_police.views.should have_at_least(1).items
      @the_police.views.first.should be_kind_of(Ken::View)
      @the_police.views.first.type.should be_kind_of(Ken::Type)
    end
  end
end