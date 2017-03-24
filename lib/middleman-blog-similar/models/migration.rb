module Middleman
  module Blog
    module Similar
      module Migration
        def self.apply
          ActiveRecord::Schema.define(version: 201703240752) do # rubocop:disable Style/NumericLiterals
            unless ActiveRecord::Base.connection.data_source_exists? 'articles'
              create_table :articles do |table|
                table.column :page_id, :string, index: true, unique: true
                table.column :digest, :string, index: true
              end
            end

            unless ActiveRecord::Base.connection.data_source_exists? 'tags'
              create_table :tags do |table|
                table.column :name, :string, index: true, unique: true
              end
            end

            unless ActiveRecord::Base.connection.data_source_exists? 'taggings'
              create_table :taggings do |table|
                table.references :article, foreign_key: true
                table.references :tag, foreign_key: true
                table.column :weight, :integer, default: 1, null: false
              end
            end
          end
        end
      end
    end
  end
end
