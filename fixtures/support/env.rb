PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
ENV['TEST'] = 'true'
require "middleman-core"
require "middleman-blog"
require "middleman-core/step_definitions"
require 'rubygems'
$LOAD_PATH.unshift File.join(PROJECT_ROOT_PATH, 'lib')
require "middleman-blog-similar"
