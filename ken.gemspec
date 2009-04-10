Gem::Specification.new do |s|
  s.name = %q{ken}
  s.version = "0.0.2"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Aufreiter"]
  s.date = %q{2009-02-10}
  s.description = %q{Ruby API for accessing Freebase}
  s.email = ["ma [a] zive [d] at"]
  s.extra_rdoc_files = ["README.txt", "LICENSE", "TODO", "History.txt"]
  s.files = ["History.txt", "LICENSE", "Manifest.txt", "README.txt",
             "README.textile", "Rakefile", "TODO", "examples/artist.rb", 
             "lib/ken.rb", "lib/ken/attribute.rb", "lib/ken/collection.rb", "lib/ken/logger.rb",
             "lib/ken/property.rb", "lib/ken/resource.rb", "lib/ken/session.rb", "lib/ken/type.rb",
             "lib/ken/util.rb", "lib/ken/version.rb", "lib/ken/view.rb", "spec/unit/attribute_spec.rb",
             "spec/unit/property_spec.rb", "spec/unit/resource_spec.rb", "spec/unit/session_spec.rb",
             "spec/unit/type_spec.rb", "spec/unit/view_spec.rb", "spec/integration/ken_spec.rb", 
             "spec/fixtures/music_artist.json", "spec/fixtures/the_police.json", "spec/spec.opts",
             "spec/spec_helper.rb", "tasks/hoe.rb", "tasks/install.rb", "tasks/spec.rb", "tasks/gemspec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/michael/ken}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ken}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby API for accessing Freebase}
 
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
 
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
    else
      s.add_dependency(%q<extlib>, [">= 0"])
    end
  else
    s.add_dependency(%q<extlib>, [">= 0"])
  end
end