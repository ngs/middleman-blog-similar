class Middleman::Blog::Similar::Algorithm
  @@should_cache = false
  @@cache = {}
  attr_reader :article, :app
  def initialize(article)
    @article = article
  end
  def self.cache= should_cache
    @@should_cache = should_cache
  end
  def similar_articles
    @similar_articles ||= articles
      .reject{|a| a == article || a.data.published == false}
      .map do |a|
        key = [a.url, article.url].join('-')
        if !@@should_cache || !@@cache[key].present?
          @@cache[key] = [distance(a), a]
        end
        @@cache[key]
      end.sort{|x, y| x[0] <=> y[0]  }
      .map{|a| a[1] }
  end
  def distance
    0.0
  end
  def articles
    article.blog_controller.data.articles
  end
end
