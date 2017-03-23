module Middleman
  module Blog
    module Similar
      module Tagger
        class Tags
          def execute(article)
            article.tags
          end
        end
      end
    end
  end
end
