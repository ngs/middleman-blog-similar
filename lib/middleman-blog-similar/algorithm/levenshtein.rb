require 'levenshtein'

class Middleman::Blog::Similar::Algorithm::Levenshtein < ::Middleman::Blog::Similar::Algorithm
  def distance(a)
    ::Levenshtein.distance(article.body, a.body)
  end
end
