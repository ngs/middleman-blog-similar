module Middleman
  module Blog
    module Similar
      class Article < ActiveRecord::Base
        has_many :taggings
        has_many :tags, through: :taggings
        def similar_article_page_ids
          return self.class.none if tags.empty?
          # http://stackoverflow.com/a/22472153
          res = ActiveRecord::Base.connection.select_all "
            SELECT rtr.article_id FROM taggings AS rtr
              INNER JOIN taggings rtr2
                ON (rtr2.tag_id = rtr.tag_id AND rtr2.article_id = #{id})
              LEFT JOIN
                (SELECT * FROM taggings WHERE article_id = #{id}) AS r
                ON rtr.tag_id = r.tag_id
              LEFT JOIN articles a ON a.id = rtr.article_id
              WHERE rtr.article_id != #{id}
              GROUP BY rtr.article_id
              HAVING COUNT(*) > 0
              ORDER BY COUNT(*) * rtr.weight DESC, a.page_id DESC"
          ids = res.to_hash.map { |h| h['article_id'] }
          page_id_map = {}
          articles = self.class.where(id: ids).select(:id, :page_id)
          articles.each do |a|
            page_id_map[a.id] = a.page_id
          end
          ids.map { |id| page_id_map[id] }
        end
      end
    end
  end
end
