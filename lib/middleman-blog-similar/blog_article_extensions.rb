module Middleman
  module Blog
    module Similar
      module BlogArticleExtensions
        def similar_articles
          if !@similar_articles && (engine = app.similarity_engine)
            @similar_articles = engine.new(self).similar_articles
          end
          @similar_articles || []
        end
      end
    end
  end
end
