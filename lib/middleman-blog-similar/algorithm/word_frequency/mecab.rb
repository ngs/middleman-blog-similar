# -*- coding: UTF-8 -*-

require 'middleman-blog-similar/algorithm/word_frequency'

class Middleman::Blog::Similar::Algorithm::WordFrequency::Mecab < ::Middleman::Blog::Similar::Algorithm::WordFrequency
  class CommandNotFound < StandardError; end
  def words
    res = []
    IO.popen("mecab 2>/dev/null", 'r+') {|f|
      f.puts article.untagged_body
      f.puts article.title
      f.close_write
      while line = f.gets
        word, pos = line.split(/[\t\s]+/)
        res << word if pos && pos.start_with?('名詞')
      end
    }
    res
  end
end
