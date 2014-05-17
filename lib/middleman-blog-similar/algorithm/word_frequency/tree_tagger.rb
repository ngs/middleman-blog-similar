require 'middleman-blog-similar/algorithm/word_frequency'
require 'tree_tagger/tagger'

class Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger < ::Middleman::Blog::Similar::Algorithm::WordFrequency
  def words
    tagger = TreeTagger::Tagger.new
    tagger.process body
    tagger.get_output
  end
end
