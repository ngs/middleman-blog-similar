require "sqlite3"
require 'digest'

class Middleman::Blog::Similar::Algorithm
  @@db_name = "middleman-blog-similar"
  @@should_cache = false
  attr_reader :article, :app
  def initialize(article)
    @article = article
  end
  def self.cache= should_cache
    puts "enabled middleman-blog-similar caching: #{should_cache}"
    @@should_cache = should_cache
  end
  def self._db_path
    @@db_path ||= ".tmp/#{@@db_name}.db".tap do |path|
      `mkdir -p .tmp`
    end
  end
  def self._db
    @@db ||= SQLite3::Database.new(_db_path).tap do |db|
      db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS cache (
        id text,
        val text
      )
      SQL
    end
  end
  def self._find key
    _db.execute("SELECT * FROM cache WHERE id = ?", key).tap do |res|
      unless res && res.length > 0
        puts "cache miss: _find #{key}: #{res}"
        return nil
      end
    end.first.last.to_i
  end
  def self._set key, val
    #puts "_set #{key}, #{val}"
    _db.execute "DELETE FROM cache WHERE id = ?", key
    _db.execute "INSERT INTO cache (id, val) VALUES (?,?)", key, val
  end
  def similar_articles
    @similar_articles ||= articles
      .reject{|a| a.url == article.url || a.data.published == false}
      .map do |a|
        # key is the hash of this article and the compared article
        key = Digest::SHA256.hexdigest [article.title, article.body, a.title, a.body].join(',')
        dist = self.class._find(key)
        if @@should_cache && !dist
          dist = distance(a)
          self.class._set(key, dist)
        end
        #puts "dist: #{dist}"
        dist ||= self.class._find(key) || distance(a)
        [dist, a]
      end.sort{|x, y| x[0] <=> y[0]  }
      .map{|a| a[1] }
  end
  def distance
    0.0
  end
  def articles
    article.blog_controller.data.articles
  end
end
