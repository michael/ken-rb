require 'pathname'
require 'rubygems'
require 'spec'

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path
require SPEC_ROOT.parent + 'lib/ken'


Spec::Runner.configure do |config|
  config.after(:all) do

  end
end
