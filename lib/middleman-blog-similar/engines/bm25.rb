require 'matrix'
require 'tf-idf-similarity'

module Middleman
  module Blog
    module Similar
      module Engines
        class Bm25 < Base
          def similar_articles
            [] # TODO
          end
        end
      end
    end
  end
end
