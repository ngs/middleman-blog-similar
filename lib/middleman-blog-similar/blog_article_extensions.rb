module Middleman
  module Blog
    module Similar
      module BlogArticleExtensions
        def similar_articles( limit = 5 )

        end
        def similar_engine=(engine)
          @@similar_engine = engine
        end
        def similar_engine
          @@similar_engine
        end
      end
    end
  end
end
