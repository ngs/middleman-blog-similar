Feature: Default

  Scenario: iterate simlar_articles
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :blog do|blog|
        blog.layout = "article"
      end
      activate :similar
      """
    Given the Server is running at "test-app"
    When I go to "/2014/05/08/article0.html"
    Then I should see "<h1>Article 0</h1>"
    Then I should see '<body data-similar-article-count="6">'
    Then I should see '<li class="a0"><a href="/2014/05/12/article4.html"><span class="title">Article 4</span><span class="tags">dog, cat, fox</span></a></li>'
    Then I should see '<li class="a1"><a href="/2014/05/09/article1.html"><span class="title">Article 1</span><span class="tags">dog, cat</span></a></li>'
    Then I should see '<li class="a2"><a href="/2014/05/10/article2.html"><span class="title">Article 2</span><span class="tags">quick, Fox</span></a></li>'
    Then I should see '<li class="a3"><a href="/2014/05/14/article6.html"><span class="title">Article 6</span><span class="tags">dog, cat</span></a></li>'
    Then I should see '<li class="a4"><a href="/2014/05/11/article3.html"><span class="title">Article 3</span><span class="tags">fox</span>'
    When I go to "/page.html"
    Then I should see '<body data-similar-article-count="0">'
