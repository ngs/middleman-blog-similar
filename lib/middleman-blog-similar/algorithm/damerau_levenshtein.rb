require 'damerau-levenshtein'

class Middleman::Blog::Similar::Algorithm::DamerauLevenshtein < ::Middleman::Blog::Similar::Algorithm
  def distance(a)
    ::DamerauLevenshtein.distance article.body, a.body
  end
end
