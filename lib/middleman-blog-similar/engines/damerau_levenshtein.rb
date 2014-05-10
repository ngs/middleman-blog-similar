require 'levenshtein'

module Middleman
  module Blog
    module Similar
      module Engines
        module Levenshtein
          def distance(string1, string2)
            Levenshtein.distance string1, string2
          end
        end
      end
    end
  end
end
