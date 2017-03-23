module Middleman
  module Blog
    module Similar
      class ResourceListManipulator
        attr_reader :article, :app, :db
        def initialize(app, blog_controller, db)
          @app = app
          @db = db
          @blog_controller = blog_controller
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
