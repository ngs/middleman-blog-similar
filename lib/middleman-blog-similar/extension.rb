require 'middleman-blog-similar/blog_article_extensions'
require 'middleman-blog-similar/helpers'
require 'middleman-blog-similar/engines/base'

module Middleman
  module Blog
    class SimilarExtension < ::Middleman::Extension

      option :engine, :levenshtein, 'Similar lookup engine'

      self.defined_helpers = [ Middleman::Blog::Similar::Helpers ]

      def after_configuration
        require 'middleman-blog/blog_article'
        ::Middleman::Sitemap::Resource.send :include, Middleman::Blog::Similar::BlogArticleExtensions
        engine = options[:engine].to_s
        begin
          require "middleman-blog-similar/engines/#{engine}"
          engine = ::Middleman::Blog::Similar::Engines.const_get engine.camelize
          app.set :similarity_engine, engine
        rescue LoadError => e
          app.logger.error "Requested similar engine '#{engine}' not found."
          raise e
        end
      end

    end
  end
end
