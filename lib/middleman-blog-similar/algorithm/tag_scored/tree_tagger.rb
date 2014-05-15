require 'middleman-blog-similar/algorithm'

module Middleman
  module Blog
    module Similar
      class Algorithm
        class TagScored < Algorithm
          class TreeTagger < TagScored
            def auto_tags
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
