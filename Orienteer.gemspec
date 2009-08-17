# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Orienteer}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jude Sutton"]
  s.date = %q{2009-08-17}
  s.description = %q{Orienteer will map out the routes through your app and find anomalies(??)}
  s.email = %q{jude.sutton@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "Orienteer.gemspec",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/Orienteer.rb",
     "tasks/orienteer.rake",
     "test/Orienteer_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/slowjud/Orienteer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Orienteer can navigate round your rails app with little more than a compass and a map.}
  s.test_files = [
    "test/Orienteer_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
