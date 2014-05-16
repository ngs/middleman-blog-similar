require 'middleman-blog-similar/algorithm'

module Middleman
  module Blog
    module Similar
      class Algorithm
        class WordFrequency < Algorithm
          class TreeTagger < WordFrequency
            def words
              require 'treetagger-ruby'
              tagger = TreeTagger::Tagger.new
              tagger.process body
              tagger.get_output
            end
          end
        end
      end
    end
  end
end
