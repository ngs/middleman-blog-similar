require 'sqlite3'

module Middleman
  module Blog
    module Similar
      class Database
        attr_reader :db, :tagger
        def initialize(path, tagger)
          @db = SQLite3::Database.new path
          @tagger = tagger
          @id_map = {}
          @db.execute_batch <<-SQL
          CREATE TABLE IF NOT EXISTS `articles` (
            `id` VARCHAR PRIMARY KEY,
            `digest` VARCHAR
          );
          CREATE TABLE IF NOT EXISTS `tags` (
            `name` VARCHAR PRIMARY KEY NOT NULL UNIQUE
          );
          CREATE TABLE IF NOT EXISTS `article_tags` (
            `article_id` VARCHAR NOT NULL REFERENCES `articles` (`id`),
            `tag_name` VARCHAR NOT NULL REFERENCES `tags` (`name`),
            UNIQUE(`article_id`, `tag_name`)
          );
          SQL
        end

        def store_articles(resources)
          @id_map = {}
          @db.transaction do |db|
            ids = []
            resources.each do |res|
              next unless res.is_a?(Middleman::Blog::BlogArticle)
              execute_article db, res
              ids << res.page_id
              @id_map[res.page_id.to_s] = res
            end
            unless ids.empty?
              joined_ids = "'#{ids.join("','")}'"
              db.execute("DELETE FROM `articles` WHERE `id` NOT IN (#{joined_ids})")
              db.execute("DELETE FROM `article_tags` WHERE `article_id` NOT IN (#{joined_ids})")
            end
          end
        end

        def execute_article(db, article)
          source_file = article.source_file
          page_id = article.page_id
          digest = ::Digest::SHA1.file(source_file).hexdigest
          result = db.execute('SELECT `digest` FROM `articles` WHERE `id` = ?', page_id)
          return page_id if result.any? && result[0] == digest
          tags = @tagger.execute article
          db.execute('INSERT OR IGNORE INTO `articles`(`id`) VALUES(?)', page_id)
          db.execute('UPDATE `articles` SET `digest` = ? WHERE `id` = ?', digest, page_id)
          return page_id if tags.empty?
          # FIXME: escaping
          db.execute("DELETE FROM `article_tags` WHERE `article_id` = '#{page_id}' AND `tag_name` NOT IN ('#{tags.join("', '")}')")
          db.execute("INSERT OR IGNORE INTO `tags`(`name`) VALUES('#{tags.join("'), ('")}')")
          tags.each do |tag|
            db.execute('INSERT OR IGNORE INTO `article_tags`(`article_id`, `tag_name`) VALUES(?, ?)', page_id, tag)
          end
          page_id
        end

        def find_similar(article)
          sql = <<-SQL
          SELECT rtr.article_id FROM article_tags AS rtr
            LEFT JOIN
              (SELECT * FROM article_tags WHERE article_id = ?) AS r
            ON rtr.tag_name = r.tag_name
            WHERE rtr.article_id <> ?
            GROUP BY rtr.article_id
            HAVING COUNT(*) > 0
            ORDER BY COUNT(*) DESC, rtr.article_id
          SQL
          page_id = article.page_id
          results = db.execute(sql, page_id, page_id)
          results.map do |row|
            @id_map[row[0]]
          end
        end
      end
    end
  end
end
