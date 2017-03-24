module Middleman
  module Blog
    module Similar
      class Tag < ActiveRecord::Base
        has_many :taggings
        has_many :articles, through: :taggings
      end
    end
  end
end
