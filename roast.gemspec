# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{roast}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Daigle"]
  s.date = %q{2009-06-15}
  s.default_executable = %q{roast}
  s.email = %q{kyle@digitalworkbox.com}
  s.executables = ["roast"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "bin/roast",
    "lib/roast.rb",
    "lib/roast/extensions.rb",
    "lib/roast/main.rb",
    "test/roast_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/kdaigle/roast}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Campfire command line tool to send simple messages to your Campfire room from the command line}
  s.test_files = [
    "test/roast_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tinder>, [">= 0"])
    else
      s.add_dependency(%q<tinder>, [">= 0"])
    end
  else
    s.add_dependency(%q<tinder>, [">= 0"])
  end
end
