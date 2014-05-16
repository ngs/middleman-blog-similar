require 'damerau-levenshtein'

module Middleman
  module Blog
    module Similar
      class Algorithm
        class DamerauLevenshtein < Algorithm
          def distance(a)
            ::DamerauLevenshtein.distance article.body, a.body
          end
        end
      end
    end
  end
end
