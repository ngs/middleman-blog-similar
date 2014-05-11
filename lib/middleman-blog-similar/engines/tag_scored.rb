require 'levenshtein'

# logic ported from https://plugins.trac.wordpress.org/browser/wordpress-23-related-posts-plugin/trunk/recommendations.php

module Middleman
  module Blog
    module Similar
      module Engines
        class TagScored < Base
          def similar_articles
            # TODO:
            []
          end
        end
      end
    end
  end
end
