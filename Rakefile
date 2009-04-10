require 'pathname'
require 'rubygems'

ROOT    = Pathname(__FILE__).dirname.expand_path
JRUBY   = RUBY_PLATFORM =~ /java/
WINDOWS = Gem.win_platform?
SUDO    = (WINDOWS || JRUBY) ? '' : ('sudo' unless ENV['SUDOLESS'])

require ROOT + 'lib/ken/version'

AUTHOR           = 'Michael Aufreiter'
EMAIL            = 'ma[at]zive[dot]at'
GEM_NAME         = 'ken'
GEM_VERSION      = '0.0.2'# Ken::VERSION
GEM_DEPENDENCIES = [
  [ 'extlib', '>=0.9.10'     ]
  # [ 'addressable', '~>2.0.1' ]
]

GEM_CLEAN  = %w[ log pkg coverage ]
GEM_EXTRAS = { :has_rdoc => true, :extra_rdoc_files => %w[ README.txt LICENSE TODO History.txt ] }

PROJECT_NAME        = 'ken'
PROJECT_URL         = "http://github.com/michael/#{GEM_NAME}"
PROJECT_DESCRIPTION = PROJECT_SUMMARY = 'Ruby API for Accessing the Freebase'

#[ ROOT, ROOT.parent ].each do |dir|
[ ROOT ].each do |dir|
  Pathname.glob(dir.join('tasks/**/*.rb').to_s).each { |f| require f }
end