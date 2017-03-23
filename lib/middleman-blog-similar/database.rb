require 'sqlite3'
require 'active_record'
require 'middleman-blog-similar/models/article'
require 'middleman-blog-similar/models/tag'
require 'middleman-blog-similar/models/tagging'
require 'middleman-blog-similar/models/migration'

module Middleman
  module Blog
    module Similar
      class Database
        attr_reader :tagger
        def initialize(path, tagger)
          ActiveRecord::Base.establish_connection(
            adapter: 'sqlite3',
            database: path
          )
          Migration.apply
          @tagger = tagger
          @id_map = {}
        end

        def store_articles(resources)
          @id_map = {}
          ActiveRecord::Base.transaction do
            ids = []
            resources.each do |res|
              next unless res.is_a?(Middleman::Blog::BlogArticle)
              execute_article res
              ids << res.page_id
              @id_map[res.page_id.to_s] = res
            end
            Article.where.not(page_id: ids).delete_all unless ids.empty?
          end
        end

        def execute_article(article)
          source_file = article.source_file
          page_id = article.page_id
          digest = ::Digest::SHA1.file(source_file).hexdigest
          return page_id if Article.exists?(digest: digest, page_id: page_id)
          tags = @tagger.execute(article).map(&:downcase)
          article = Article.find_or_create_by(page_id: page_id)
          article.update! digest: digest
          return page_id if tags.empty?
          # FIXME: escaping
          article.tags = []
          tags.each do |tag|
            tag = Tag.find_or_create_by name: tag.downcase
            article.tags << tag
          end
          article.save!
          page_id
        end

        def find_similar(article)
          article = Article.find_by(page_id: article.page_id)
          return [] unless article
          article.similar_article_page_ids.map do |page_id|
            @id_map[page_id]
          end
        end
      end
    end
  end
end
