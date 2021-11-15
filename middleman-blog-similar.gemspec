# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'middleman-blog-similar/version'

Gem::Specification.new do |s|
  s.name = 'middleman-blog-similar'
  s.version = Middleman::Blog::Similar::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Atsushi Nagase']
  s.email = ['a@ngs.io']
  s.homepage = 'https://github.com/ngs/middleman-blog-similar'
  s.summary = 'Similar article extension for middleman-blog'
  s.description = <<-EOF
    Similar article extension for middleman-blog.
    Finds similar articles using tags, part-of-speech or custom lambda.
  EOF
  s.license = 'MIT'
  s.files = `git ls-files -z`.split("\0")
  s.test_files = `git ls-files -z -- {fixtures,features,spec}/*`.split("\0")
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.2.0'
  s.add_runtime_dependency 'activerecord', '~> 6.1', '>= 6.1.0'
  s.add_runtime_dependency 'middleman-core', '~> 4.0', '>= 4.0.0'
  s.add_runtime_dependency 'middleman-blog', '~> 4.0', '>= 4.0.0'
  s.add_dependency 'sqlite3', '~> 1.3'
end
