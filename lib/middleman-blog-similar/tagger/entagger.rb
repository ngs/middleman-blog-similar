require 'engtagger'

module Middleman
  module Blog
    module Similar
      module Tagger
        class Entagger
          def call(article)
            tgr = EngTagger.new
            tagged = tgr.add_tags article.body.gsub(%r{</?[^>]+>}, '')
            tgr.get_nouns(tagged).keys
          end
        end
      end
    end
  end
end
