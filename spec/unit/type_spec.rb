require 'pathname'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe Ken::Type do
  before :all do
    Ken::Logger.new(STDOUT, :info)
    Ken::Session.new('http://www.freebase.com', 'ma', 'xxxxx')

    # fetch a type
    @type = Ken.get("/en/the_police").types.first
  end
    
  it 'should have an id and a name' do
    puts @type.id
  end
  
  it 'should have properties' do
    @type.properties.should have_at_least(1).items
  end
end