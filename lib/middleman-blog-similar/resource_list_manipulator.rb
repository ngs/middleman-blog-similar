module Middleman
  module Blog
    module Similar
      class ResourceListManipulator
        attr_reader :article, :app, :db
        def initialize(app, db)
          @app = app
          @db = db
        end

        def manipulate_resource_list(resources)
          resources.each { |res| res.add_metadata locals: { similar_db: @db } }
          @db.store_articles resources
          resources
        end
      end
    end
  end
end
