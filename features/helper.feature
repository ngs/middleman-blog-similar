Feature: Similar extension

  Scenario: Basic
    Given the Server is running at "test-app"
    When I go to "/"
    Then I should see '<h1>Hello index</h1>'
