module Middleman
  module Blog
    module Similar
      module Helpers
        def similar_articles
          if is_blog_article?
            current_article.similar_articles
          else
            []
          end
        end
      end
    end
  end
end
