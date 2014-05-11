module Middleman
  module Blog
    module Similar
      module Engines
        class Base
          attr_reader :article, :app
          def initialize(article)
            @article = article
          end
          def similar_articles
            @similar_articles ||= articles
              .reject{|a| a == article }
              .map{|a| [distance(a), a] }
              .sort{|x, y| x[0] <=> y[0]  }
              .map{|a| a[1] }
          end
          def distance a
            0
          end
          def articles
            article.blog_controller.data.articles
          end
        end
      end
    end
  end
end
