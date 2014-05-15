module Middleman
  module Blog
    module Similar
      class Algorithm
        attr_reader :article, :app
        def initialize(article)
          @article = article
        end
        def similar_articles
          []
        end
        def articles
          article.blog_controller.data.articles
        end
      end
    end
  end
end
