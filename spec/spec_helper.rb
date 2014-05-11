PROJECT_ROOT_PATH = File.dirname(File.dirname(__FILE__))

require 'rubygems'
$LOAD_PATH.unshift File.join(PROJECT_ROOT_PATH, 'lib')
require 'spork'
require 'rspec'
require "middleman-core"
require "middleman-blog"
require "middleman-blog/helpers"


# Memo: https://github.com/middleman/middleman/issues/737#issuecomment-14122832
module SpecHelpers; end

Spork.prefork do
  RSpec.configure do |config|
    config.include SpecHelpers
  end
  require "middleman-blog-similar"
  require "middleman-blog-similar/extension"
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
