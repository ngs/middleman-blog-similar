require 'middleman-blog-similar/algorithm/word_frequency'

class Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger < ::Middleman::Blog::Similar::Algorithm::WordFrequency
  class CommandNotFound < StandardError; end
  def words
    raise CommandNotFound.new "You need to tree tagger command with ENV['TREETAGGER_COMMAND']" unless ENV['TREETAGGER_COMMAND']
    res = []
    IO.popen("#{ ENV['TREETAGGER_COMMAND'] } 2>/dev/null", 'r+') {|f|
      f.puts article.untagged_body
      f.puts article.title
      f.close_write
      while line = f.gets
        res << line.split(/\s+/)[0]
      end
    }
    res
  end
end
