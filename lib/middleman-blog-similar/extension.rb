require 'middleman-blog-similar/blog_article_extensions'
require 'middleman-blog-similar/helpers'
require 'middleman-blog-similar/algorithm'

module Middleman
  module Blog
    class SimilarExtension < ::Middleman::Extension

      option :algorithm, :tag_scored, 'Similar lookup algorithm'

      self.defined_helpers = [ Middleman::Blog::Similar::Helpers ]

      def after_configuration
        require 'middleman-blog/blog_article'
        ::Middleman::Sitemap::Resource.send :include, Middleman::Blog::Similar::BlogArticleExtensions
        algorithm = options[:algorithm].to_s
        begin
          require "middleman-blog-similar/algorithm/#{algorithm}"
          algorithm = ::Middleman::Blog::Similar::Algorithm.const_get algorithm.split('/').map(&:camelize).join('::')
          app.set :similarity_algorithm, algorithm
        rescue LoadError => e
          app.logger.error "Requested similar algorithm '#{algorithm}' not found."
          raise e
        end
      end

    end
  end
end
