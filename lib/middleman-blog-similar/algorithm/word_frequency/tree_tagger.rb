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
        word, pos = line.split(/\s+/)
        # http://courses.washington.edu/hypertxt/csar-v02/penntable.html
        res << word if %w{NN JJ NP}.include? pos[0..2]
      end
    }
    res
  end
end
