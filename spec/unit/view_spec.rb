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
    @view.type.should be_kind_of(Ken::Type)
  end
  
  it "should have properties" do
    @view.properties.should_not be_nil
    @view.properties.each { |p| p.should be_kind_of(Ken::Property)}
  end
  
  it "should have attributes" do
    @view.attributes.should_not be_nil
    @view.attributes.each { |p| p.should be_kind_of(Ken::Attribute)}
  end
end

