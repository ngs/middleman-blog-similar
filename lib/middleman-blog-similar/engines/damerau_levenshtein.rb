require 'damerau-levenshtein'

module Middleman
  module Blog
    module Similar
      module Engines
        class DamerauLevenshtein < Base
          def distance(a)
            ::DamerauLevenshtein.distance article.body, a.body
          end
        end
      end
    end
  end
end
