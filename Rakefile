require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ken"
    gem.summary = %Q{Ruby API for Accessing the Freebase}
    gem.email = "ma[at]zive[dot]at"
    gem.homepage = "http://github.com/michael/ken"
    gem.authors = ["michael"]
    # gem.files = FileList["[A-Z]*.*"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ken #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



# require 'pathname'
# require 'rubygems'
# 
# ROOT    = Pathname(__FILE__).dirname.expand_path
# JRUBY   = RUBY_PLATFORM =~ /java/
# WINDOWS = Gem.win_platform?
# SUDO    = (WINDOWS || JRUBY) ? '' : ('sudo' unless ENV['SUDOLESS'])
# 
# require ROOT + 'lib/ken/version'
# 
# AUTHOR           = 'Michael Aufreiter'
# EMAIL            = 'ma[at]zive[dot]at'
# GEM_NAME         = 'ken'
# GEM_VERSION      = '0.0.2'# Ken::VERSION
# GEM_DEPENDENCIES = [
#   [ 'extlib', '>=0.9.10'     ]
#   # [ 'addressable', '~>2.0.1' ]
# ]
# 
# GEM_CLEAN  = %w[ log pkg coverage ]
# GEM_EXTRAS = { :has_rdoc => true, :extra_rdoc_files => %w[ README.txt LICENSE TODO History.txt ] }
# 
# PROJECT_NAME        = 'ken'
# PROJECT_URL         = "http://github.com/michael/#{GEM_NAME}"
# PROJECT_DESCRIPTION = PROJECT_SUMMARY = 'Ruby API for Accessing the Freebase'
# 
# #[ ROOT, ROOT.parent ].each do |dir|
# [ ROOT ].each do |dir|
#   Pathname.glob(dir.join('tasks/**/*.rb').to_s).each { |f| require f }
# end