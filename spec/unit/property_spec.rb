require 'pathname'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Ken::Property do
  before :all do
    Ken::Logger.new(STDOUT, :info)
    # Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')
    data = load_fixture('music_artist')
    @type = Ken::Type.new(data)
    @value_property = @type.properties[1]
    @object_property = @type.properties[3]
  end
    
  it 'should be a valid property instance' do
    @value_property.should be_kind_of(Ken::Property)
    @object_property.should be_kind_of(Ken::Property)
  end
  
  it 'should have a type' do
    @value_property.type.should be_kind_of(Ken::Type)
    @object_property.type.should be_kind_of(Ken::Type)
  end
  
  it 'should distinguish wheter it is an object or value type' do
    @value_property.object_type?.should == false
    @object_property.object_type?.should == true
  end
end

