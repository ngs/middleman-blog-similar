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
        attr_reader :taggers
        def initialize(path, taggers)
          ActiveRecord::Base.establish_connection(
            adapter: 'sqlite3',
            database: path
          )
          Migration.apply
          @taggers = taggers
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

        def execute_article(resource)
          source_file = resource.source_file
          page_id = resource.page_id
          digest = ::Digest::SHA1.file(source_file).hexdigest
          return page_id if Article.exists?(digest: digest, page_id: page_id)
          article = Article.find_or_create_by(page_id: page_id)
          new_tagging_ids = []
          @taggers.each do |tagger|
            tagger[1].call(resource).map(&:downcase).each do |tag_name|
              tag = Tag.find_or_create_by name: tag_name
              tagging = Tagging.find_or_create_by tag_id: tag.id, article_id: article.id
              tagging.weight = tagger[0]
              tagging.save!
              new_tagging_ids << tagging.id
            end
          end
          if new_tagging_ids.any?
            article.taggings.where.not(id: new_tagging_ids).delete_all
          end
          article.update! digest: digest
          page_id
        end

        def find_similar(article)
          article = Article.find_by(page_id: article.page_id)
          return [] unless article
          article.similar_article_page_ids.map do |page_id|
            @id_map[page_id]
          end.select(&:present?)
        end
      end
    end
  end
end
