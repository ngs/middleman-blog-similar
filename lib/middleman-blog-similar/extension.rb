require 'middleman-blog-similar/blog_article_extensions'

module Middleman
  module Blog
    class SimilarExtension < ::Middleman::Extension

      option :engine, :levenshtein, 'Similar lookup engine'

      def after_configuration
        require 'middleman-blog/blog_article'
        ::Middleman::Blog::BlogArticle.send :include, Middleman::Blog::Similar::BlogArticleExtensions
        engine = options[:engine].to_s
        begin
          require "middleman-blog-similar/engines/#{engine}"
          ::Middleman::Blog::Similar::Engines.const_get engine.camelize
        rescue LoadError => e
          app.logger.error "Requested similar engine '#{engine}' not found."
          raise e
        end
      end

      helpers do
        def similar_articles( limit = 5 )
          current_article.similar_articles limit
        end
      end

    end
  end
end
