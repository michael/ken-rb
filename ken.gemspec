# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ken}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["michael"]
  s.date = %q{2009-07-08}
  s.email = %q{ma[at]zive[dot]at}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile",
     "README.txt"
  ]
  s.files = [
    ".gitignore",
     "History.txt",
     "LICENSE",
     "README.textile",
     "README.txt",
     "Rakefile",
     "TODO",
     "VERSION",
     "examples/artist.rb",
     "examples/artist_links.rb",
     "ken.gemspec",
     "lib/ken.rb",
     "lib/ken/attribute.rb",
     "lib/ken/collection.rb",
     "lib/ken/logger.rb",
     "lib/ken/property.rb",
     "lib/ken/resource.rb",
     "lib/ken/session.rb",
     "lib/ken/type.rb",
     "lib/ken/util.rb",
     "lib/ken/view.rb",
     "rails/init.rb",
     "tasks/ken.rb",
     "tasks/spec.rb",
     "test/fixtures/music_artist.json",
     "test/fixtures/the_police.json",
     "test/integration/ken_test.rb",
     "test/test_helper.rb",
     "test/unit/attribute_test.rb",
     "test/unit/property_test.rb",
     "test/unit/resource_test.rb",
     "test/unit/session_test.rb",
     "test/unit/type_test.rb",
     "test/unit/view_test.rb"
  ]
  s.homepage = %q{http://github.com/michael/ken}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Ruby API for Accessing the Freebase}
  s.test_files = [
    "test/integration/ken_test.rb",
     "test/test_helper.rb",
     "test/unit/attribute_test.rb",
     "test/unit/property_test.rb",
     "test/unit/resource_test.rb",
     "test/unit/session_test.rb",
     "test/unit/type_test.rb",
     "test/unit/view_test.rb",
     "examples/artist.rb",
     "examples/artist_links.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
    else
      s.add_dependency(%q<extlib>, [">= 0"])
    end
  else
    s.add_dependency(%q<extlib>, [">= 0"])
  end
end
