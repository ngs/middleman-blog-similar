module Middleman
  module Blog
    module Similar
      module BlogArticleExtensions
        def similar_articles
          if !@similar_articles && similarity_engine
            @similar_articles = similarity_engine.similar_articles
          end
          @similar_articles || []
        end
        def words
          unless @words && similarity_engine
            @words = similarity_engine.words
          end
          @words
        end
        def similarity_engine
          unless @similarity_engine && (engine = app.similarity_engine)
            @similarity_engine = engine.new self
          end
          @similarity_engine
        end
        def untagged_body
          body.gsub(/<[^>]*>/ui,'')
        end
      end
    end
  end
end
