Feature: DamerauLevenshtein similarity algorithm

  Scenario: iterate simlar_articles
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :blog do|blog|
        blog.layout = "article"
      end
      activate :similar, :algorithm => :word_frequency
      """
    Given the Server is running at "test-app"
    When I go to "/2014/05/08/article0.html"
    Then I should see "<h1>Article 0</h1>"
    Then I should see '<blockquote class="algorithm">Middleman::Blog::Similar::Algorithm::WordFrequency</blockquote>'
