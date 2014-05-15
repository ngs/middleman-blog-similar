require 'middleman-blog-similar/algorithm/levenshtein'
require 'damerau-levenshtein'

module Middleman
  module Blog
    module Similar
      class Algorithm
        class DamerauLevenshtein < Levenshtein
          def distance(a)
            ::DamerauLevenshtein.distance article.body, a.body
          end
        end
      end
    end
  end
end
