require 'levenshtein'

module Middleman
  module Blog
    module Similar
      class Algorithm
        class Levenshtein < Algorithm
          def distance(a)
            ::Levenshtein.distance(article.body, a.body)
          end
        end
      end
    end
  end
end
