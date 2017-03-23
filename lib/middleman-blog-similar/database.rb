require 'sqlite3'
require 'active_record'

module Middleman
  module Blog
    module Similar
      class Article < ActiveRecord::Base
        has_and_belongs_to_many :tags
        def similar_article_page_ids
          return self.class.none if tags.empty?
          res = ActiveRecord::Base.connection.select_all "
            SELECT rtr.article_id FROM articles_tags AS rtr
              LEFT JOIN
                (SELECT * FROM articles_tags WHERE article_id = #{id}) AS r
              ON rtr.tag_id = r.tag_id
              WHERE rtr.article_id <> #{id}
              GROUP BY rtr.article_id
              HAVING COUNT(*) > 0
              ORDER BY COUNT(*) DESC, rtr.article_id"
          ids = res.to_hash.map { |h| h['article_id'] }
          page_id_map = {}
          articles = self.class.where(id: ids)
          articles.each do |a|
            page_id_map[a.id] = a.page_id
          end
          ids.map { |id| page_id_map[id] }
        end
      end

      class Tag < ActiveRecord::Base
        has_and_belongs_to_many :articles
      end

      class Database
        attr_reader :tagger
        def initialize(path, tagger)
          ActiveRecord::Base.establish_connection(
            adapter: 'sqlite3',
            database: path
          )
          ActiveRecord::Schema.define do
            unless ActiveRecord::Base.connection.data_source_exists? 'articles'
              create_table :articles do |table|
                table.column :page_id, :string, index: true, unique: true
                table.column :digest, :string, index: true
              end
            end

            unless ActiveRecord::Base.connection.data_source_exists? 'tags'
              create_table :tags do |table|
                table.column :name, :string, index: true, unique: true
              end
            end

            unless ActiveRecord::Base.connection.data_source_exists? 'articles_tags'
              create_table :articles_tags do |table|
                table.references :article, foreign_key: true
                table.references :tag, foreign_key: true
              end
            end
          end

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
