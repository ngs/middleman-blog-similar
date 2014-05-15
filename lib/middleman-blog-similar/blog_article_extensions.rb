module Middleman
  module Blog
    module Similar
      module BlogArticleExtensions
        def similar_articles
          if !@similar_articles && similarity_algorithm
            @similar_articles = similarity_algorithm.similar_articles
          end
          @similar_articles || []
        end
        def words
          unless @words && similarity_algorithm
            @words = similarity_algorithm.words
          end
          @words
        end
        def similarity_algorithm
          if !@similarity_algorithm && (algorithm = app.similarity_algorithm)
            @similarity_algorithm = algorithm.new self
          end
          @similarity_algorithm
        end
        def untagged_body
          body.gsub(/<[^>]*>/ui,'')
        end
      end
    end
  end
end
