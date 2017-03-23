module Middleman
  module Blog
    module Similar
      class Tagging < ActiveRecord::Base
        belongs_to :article
        belongs_to :tag
      end
    end
  end
end
