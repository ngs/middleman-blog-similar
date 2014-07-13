# encoding: utf-8

require 'fast-stemmer'
require 'csv'
require 'sqlite3'

# logic ported from https://plugins.trac.wordpress.org/browser/wordpress-23-related-posts-plugin/trunk/recommendations.php

class Middleman::Blog::Similar::Algorithm::WordFrequency < ::Middleman::Blog::Similar::Algorithm
  @@unigrams = nil
  @@db = nil
  STMT_SELECT_ARTICLE = "SELECT * FROM articles WHERE url=?"
  STMT_INSERT_ARTICLE = "INSERT INTO articles (url) VALUES (?)"
  class << self

    def db_path(app)
      File.join app.root, 'tmp/similar.db'
    end
    def db(app)
      path = db_path app
      if @@db.nil? or !File.exists? path
        FileUtils.mkdir_p File.dirname path
        @@db = SQLite3::Database.new path
        @@db.results_as_hash = true
        @@db.execute_batch <<-SQL
          CREATE TABLE articles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            url VARCHAR(255)
          );
          CREATE TABLE words (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255)
          );
          CREATE TABLE article_words (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            article_id INTEGER,
            word_id INTEGER,
            count INTEGER
          );
          CREATE INDEX article_url_index ON articles(url);
          CREATE INDEX word_name_index ON words(name);
          CREATE INDEX article_word_index ON article_words(article_id, word_id);
        SQL
      end
      @@db
    end
    def unigrams_path
      File.join File.dirname(__FILE__), 'unigrams.csv'
    end
    def unigrams
      if @@unigrams.nil?
        @@unigrams = {}
        CSV.foreach(unigrams_path, { :col_sep => "\t" }) do|row|
          @@unigrams[row[0]] = row[4].to_f if row.length == 5
        end
      end
      @@unigrams
    end
  end
  def db
    self.class.db article.app
  end
  def db_path
    self.class.db_path article.app
  end
  def distance a
    d = 0xffffff
    wf = a.similarity_algorithm.word_freq
    word_freq.each do|word, freq|
      if wf.has_key? word
        d -= wf[word] * freq
      end
    end
    d
  end
  def cache_id
    return @cache_id if @cache_id
    res = db.query STMT_SELECT_ARTICLE, [article.url]
    unless res.count > 0
      db.execute STMT_INSERT_ARTICLE, [article.url]
      res = db.query STMT_SELECT_ARTICLE, [article.url]
    end
    @cache_id = res.first['id']
  end
  def words
    re = /[\t\s\n,\.、。　]/
    article.untagged_body.split(re) + article.title.split(re)
  end
  def generate_word_freq
    suitable_words = unigrams.dup
    word_freq= {}
    words.each do|word|
      word.downcase!
      word = word.stem if word =~ /^\w+$/
      word_freq[word] ||= 0
      word_freq[word] += 1
    end
    selected_words = {}
    word_freq.each do|word, freq|
      selected_words[word] = unigrams[word] * Math.sqrt(freq) if unigrams[word]
    end
    article.tags.each do|tag|
      tag = tag.downcase.stem
      word_freq[tag] ||= 0
      word_freq[tag] += tag_weight
    end
    Hash[ word_freq.sort_by{|k, v| k }.sort_by{|k, v| v } ]
  end
  def word_freq_from_db
    cache_id
    nil
  end
  def word_freq
    @word_freq ||= word_freq_from_db || generate_word_freq
  end
  def generate_tags
    generate_word_freq.keys.reverse
  end
  def tags
    @tags ||= generate_tags
  end
  def tag_weight   ; 5                      ; end
  def unigrams     ; self.class.unigrams    ; end
end
