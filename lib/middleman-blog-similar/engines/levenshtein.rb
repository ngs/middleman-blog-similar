require 'levenshtein'

module Middleman
  module Blog
    module Similar
      module Engines
        class Levenshtein < Base
          def distance(a)
            ::Levenshtein.distance(article.body, a.body)
          end
        end
      end
    end
  end
end
