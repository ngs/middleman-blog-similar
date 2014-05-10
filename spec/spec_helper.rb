PROJECT_ROOT_PATH = File.dirname(File.dirname(__FILE__))

require 'rubygems'
$LOAD_PATH.unshift File.join(PROJECT_ROOT_PATH, 'lib')
require 'spork'
require 'rspec'

Spork.prefork do
  require "middleman-blog-similar"
end

Spork.each_run do; end

if ENV['CODECLIMATE_REPO_TOKEN']
  CodeClimate::TestReporter.start
  require "codeclimate-test-reporter"
end

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "").sub(/\n$/, '')
  end
end
