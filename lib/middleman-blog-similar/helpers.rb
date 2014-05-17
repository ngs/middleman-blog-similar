module Middleman::Blog::Similar::Helpers
  def similar_articles
    if is_blog_article?
      current_article.similar_articles
    else
      []
    end
  end
end
