# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-blog-similar/version"

Gem::Specification.new do |s|
  s.name = "middleman-blog-similar"
  s.version = Middleman::Blog::Similar::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Atsushi Nagase"]
  s.email = ["a@ngs.io"]
  s.homepage = "https://github.com/ngs/middleman-blog-similar"
  s.summary = %q{Similar article extension for middleman-blog}
  s.description = %q{Similar article extension for middleman-blog}
  s.license = "MIT"
  s.files = `git ls-files -z`.split("\0")
  s.test_files = `git ls-files -z -- {fixtures,features,spec}/*`.split("\0")
  s.require_paths = ["lib"]
  s.add_dependency("middleman-core", ["~> 4"])
  s.add_dependency("middleman-blog", ["~> 4"])
  s.add_dependency("sqlite3", ["~> 1.3"])
end
