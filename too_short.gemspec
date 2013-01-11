# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "too_short"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simon Baumgartner"]
  s.date = "2013-01-11"
  s.description = "TooShort allows you to create persistent short URLs for your resources, without any additional storage."
  s.email = "makesens3@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/ar_base_extensions.rb",
    "lib/controller_methods.rb",
    "lib/too_short.rb",
    "spec/ar_base_extensions_spec.rb",
    "spec/controller_methods_spec.rb",
    "spec/spec_helper.rb",
    "spec/test_directories/app/models/crazy_rubinius_file.rbc",
    "spec/test_directories/app/models/post.rb",
    "spec/test_directories/app/models/post_comment.rb",
    "spec/too_short_spec.rb",
    "too_short.gemspec"
  ]
  s.homepage = "http://github.com/sens3/too_short"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A URL shortener for your resources"
  s.test_files = [
    "spec/ar_base_extensions_spec.rb",
    "spec/controller_methods_spec.rb",
    "spec/spec_helper.rb",
    "spec/test_directories/app/models/post.rb",
    "spec/test_directories/app/models/post_comment.rb",
    "spec/too_short_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    s.add_dependency(%q<actionpack>, [">= 3.0.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

