# encoding: utf-8

require 'fast-stemmer'
require 'csv'

# logic ported from https://plugins.trac.wordpress.org/browser/wordpress-23-related-posts-plugin/trunk/recommendations.php

class Middleman::Blog::Similar::Algorithm::WordFrequency < ::Middleman::Blog::Similar::Algorithm
  @@unigrams = nil
  class << self
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
  def words
    re = /[\t\s\n,\.、。　]/
    article.untagged_body.split(re) + article.title.split(re)
  end
  def generate_word_freq
    suitable_words = unigrams.dup
    word_freq= {}
    words.each do|word|
      word = word.downcase.stem
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
  def word_freq
    @word_freq ||= generate_word_freq
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
