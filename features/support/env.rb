PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
ENV['TEST'] = 'true'

require 'rubygems'
require 'spork'
$LOAD_PATH.unshift File.join(PROJECT_ROOT_PATH, 'lib')

Spork.prefork do
  require "middleman-blog-similar"
end

require "middleman-core"
require "middleman-blog"
require "middleman-core/step_definitions"
