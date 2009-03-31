Gem::Specification.new do |s|
  s.name = %q{ken}
  s.version = "0.0.1"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Aufreiter"]
  s.date = %q{2009-02-10}
  s.description = %q{Ruby API for accessing Freebase}
  s.email = ["ma [a] zive [d] at"]
  s.extra_rdoc_files = ["README.txt", "LICENSE", "TODO", "History.txt"]
  s.files = [".gitignore", "History.txt", "LICENSE", "Manifest.txt", "README.txt", "Rakefile", "TODO", "ken.gemspec", "lib/ken.rb", "lib/ken/collection.rb", "lib/ken/logger.rb", "lib/ken/property.rb", "lib/ken/resource.rb", "lib/ken/session.rb", "lib/ken/type.rb", "lib/ken/version.rb", "spec/mql_spec.rb", "spec/property_spec.rb", "spec/resource_spec.rb", "spec/session_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/hoe.rb", "tasks/install.rb", "tasks/spec.rb"]
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