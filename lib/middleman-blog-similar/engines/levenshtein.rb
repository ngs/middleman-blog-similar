require 'levenshtein'

module Middleman
  module Blog
    module Similar
      module Engines
        module DamerauLevenshtein
          def distance(string1, string2)
            DamerauLevenshtein.distance string1, string2
          end
        end
      end
    end
  end
end
