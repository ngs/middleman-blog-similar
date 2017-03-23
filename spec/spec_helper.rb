PROJECT_ROOT_PATH = File.dirname(File.dirname(__FILE__))

require 'rubygems'
$LOAD_PATH.unshift File.join(PROJECT_ROOT_PATH, 'lib')
require 'rspec'
require 'rspec/collection_matchers'
require 'rspec/its'
require 'middleman-core'
require 'middleman-blog'
require 'middleman-blog/helpers'

require 'simplecov'

SimpleCov.root(File.expand_path(File.dirname(__FILE__) + '/..'))
SimpleCov.start

if ENV['COVERALLS_REPO_TOKEN']
  require 'coveralls'
  Coveralls.wear!
end

module SpecHelpers
  include FileUtils

  def middleman_app(fixture_path, &block)
    tmp_dir     = File.expand_path('../../tmp', __FILE__)
    fixture_dir = File.expand_path('../../fixtures', __FILE__)
    fixture_tmp = File.join tmp_dir, 'rspec'
    root_dir    = File.join fixture_tmp, fixture_path
    rmtree fixture_tmp
    mkdir_p tmp_dir
    cp_r fixture_dir, fixture_tmp
    ENV['MM_SOURCE'] = 'source'
    ENV['MM_ROOT'] = root_dir
    initialize_commands = @initialize_commands || []
    initialize_commands.unshift block
    initialize_commands.unshift lambda {
      set :environment, :development
      set :show_exceptions, false
      activate :blog
    }
    ::Middleman::Application.new do
      initialize_commands.each do |p|
        instance_exec(&p)
      end
    end
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end

require 'middleman-blog-similar/extension'
require 'middleman-blog-similar'

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by(&:length)}/, '').sub(/\n$/, '')
  end
end
