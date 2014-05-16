PROJECT_ROOT_PATH = File.dirname(File.dirname(__FILE__))

require 'rubygems'
$LOAD_PATH.unshift File.join(PROJECT_ROOT_PATH, 'lib')
require 'spork'
require 'rspec'
require "middleman-core"
require "middleman-blog"
require "middleman-blog/helpers"

module SpecHelpers

  def middleman_app fixture_path, &block
    tmp_dir     = File.expand_path("../../tmp", __FILE__)
    fixture_dir = File.expand_path("../../fixtures", __FILE__)
    fixture_tmp = File.join tmp_dir, "rspec"
    root_dir    = File.join fixture_tmp, fixture_path
    FileUtils::rmtree fixture_tmp
    FileUtils::mkdir_p tmp_dir
    FileUtils::cp_r fixture_dir, fixture_tmp
    ENV["MM_SOURCE"] = 'source'
    ENV["MM_ROOT"] = root_dir
    initialize_commands = @initialize_commands || []
    initialize_commands.unshift block
    initialize_commands.unshift lambda {
      set :environment, :development
      set :show_exceptions, false
      activate :blog
    }
    Middleman::Application.server.inst do
      initialize_commands.each do |p|
        instance_exec(&p)
      end
    end
  end
end

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
