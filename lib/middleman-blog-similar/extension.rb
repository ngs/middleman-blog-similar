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

        @taggers = []
        case options.tagger
          when String, Symbol
            @taggers << [1, load_tagger(options.tagger)]
          when Hash
            options.tagger.each do |k, v|
              if v.is_a?(Array)
                k = v[1]
                v = v[0]
              end
              @taggers << [v, load_tagger(k)]
            end
          else
            raise "Invalid type for tagger option: #{options.tagger.class}"
        end
        db_path = options.db
        db_path = File.expand_path(options.db, app.root) if db_path != ':memory:'
        @db = Middleman::Blog::Similar::Database.new db_path, @taggers
        @resource_list_manipulator = Middleman::Blog::Similar::ResourceListManipulator.new app, @db
        @app.sitemap.register_resource_list_manipulator :blog_similar, @resource_list_manipulator
      end

      def load_tagger(tagger)
        return tagger unless tagger.is_a?(String) || tagger.is_a?(Symbol)
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
