module Middleman
  module Blog
    module Similar
      module Tagger
        class Tags
          def call(article)
            article.tags
          end
        end
      end
    end
  end
end
