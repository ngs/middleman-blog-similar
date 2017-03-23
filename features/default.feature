Feature: Default

  Scenario: iterate simlar_articles
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      blog_controller = activate :blog do|blog|
        blog.layout = "article"
      end
      activate :similar, blog_controller: blog_controller
      """
    Given the Server is running at "test-app"
    When I go to "/2014/05/08/article0.html"
    Then I should see "<h1>Article 0</h1>"
    Then I should see '<li class="a0"><a href="/2014/05/13/article5.html">Article 5</a></li>'
    Then I should see '<li class="a1"><a href="/2014/05/09/article1.html">Article 1</a></li>'
    Then I should see '<li class="a2"><a href="/2014/05/12/article4.html">Article 4</a></li>'
    Then I should see '<li class="a3"><a href="/2014/05/14/article6.html">Article 6</a></li>'
    Then I should see '<li class="a4"><a href="/2014/05/10/article2.html">Article 2</a></li>'
