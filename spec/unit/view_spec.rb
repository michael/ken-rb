require 'pathname'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Ken::View do
  before :all do
    Ken::Logger.new(STDOUT, :info)
    data = load_fixture('the_police')
    @the_police = Ken::Resource.new(data)
    
    @view = @the_police.views.first
  end
  
  it "should have a type" do
    @view.type.should_not be_nil
  end
  
  it "should have properties" do
    @view.properties.should_not be_nil
  end
  
  it "should have attributes" do
    @view.properties.should_not be_nil
  end
end

