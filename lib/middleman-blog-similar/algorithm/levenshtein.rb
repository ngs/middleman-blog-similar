require 'levenshtein'

module Middleman
  module Blog
    module Similar
      class Algorithm
        class Levenshtein < Algorithm
          def similar_articles
            @similar_articles ||= articles
              .reject{|a| a == article }
              .map{|a| [distance(a), a] }
              .sort{|x, y| x[0] <=> y[0]  }
              .map{|a| a[1] }
          end
          def distance(a)
            ::Levenshtein.distance(article.body, a.body)
          end
        end
      end
    end
  end
end
