module Middleman
  module Blog
    module Similar
      module BlogArticleExtensions
        def similar_articles
          locals[:similar_db].find_similar(self)
        end
      end
    end
  end
end
