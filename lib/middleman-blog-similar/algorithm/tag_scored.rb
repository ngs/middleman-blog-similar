require 'sqlite3'

# logic ported from https://plugins.trac.wordpress.org/browser/wordpress-23-related-posts-plugin/trunk/recommendations.php

module Middleman
  module Blog
    module Similar
      class Algorithm
        class TagScored < Algorithm
          def similar_articles
            # TODO:
            []
          end
          def auto_tags
            article.untagged_body.downcase.split /[\t\s\n,\.、。　]/
          end
          def tags
            article.tags
          end
          def self.unigrams
            unless @@unigrams

            end
            @@unigrams
          end
          def self.tag_cache

          end
          def self.tag_cache_path
            app.tag_cache_path || File.join(app.root, 'data/tag.db')
          end
        end
      end
    end
  end
end
