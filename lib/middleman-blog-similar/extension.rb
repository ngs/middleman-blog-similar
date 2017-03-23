require 'middleman-blog-similar/blog_article_extensions'
require 'middleman-blog-similar/helpers'
require 'middleman-blog-similar/resource_list_manipulator'
require 'middleman-blog-similar/database'

module Middleman
  module Blog
    class SimilarExtension < ::Middleman::Extension
      option :tagger, :tags, 'Article tagger'
      option :db, '.similar.db', 'SQLite3 Database'

      self.defined_helpers = [Middleman::Blog::Similar::Helpers]

      def after_configuration
        require 'middleman-blog/blog_article'
        ::Middleman::Sitemap::Resource.send :include, Middleman::Blog::Similar::BlogArticleExtensions
        @tagger = load_tagger options.tagger
        @db = Middleman::Blog::Similar::Database.new File.expand_path(options.db, app.root), @tagger
        @resource_list_manipulator = Middleman::Blog::Similar::ResourceListManipulator.new app, @db
        @app.sitemap.register_resource_list_manipulator :blog_similar, @resource_list_manipulator
        @app.set :similarity_extension, self
      end

      def load_tagger(tagger)
        require "middleman-blog-similar/tagger/#{tagger}"
        ns = ::Middleman::Blog::Similar::Tagger
        tagger.to_s.split('/').each do |n|
          ns = ns.const_get n.camelize
        end
        ns.new
      rescue LoadError => e
        app.logger.error "Requested similar tagger '#{tagger}' not found."
        raise e
      end
    end
  end
end
