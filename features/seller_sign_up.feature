Feature: Seller Signup

  As a User
  So that I can begin selling items
  I want to sign up as a seller


  Scenario: restrict to movies with "PG" and "PG-13" ratings
    When I check the following ratings: "PG","PG-13"
    And I uncheck the following ratings: "R","G"
    And I press "Refresh"
    Then I should see the following movies: "Chocolat", "Raiders of the Lost Ark", "The Help", "The Incredibles"
    And I should not see the following movies: "2001: A Space Odyssey", "Aladdin", "Amelie", "Chicken Run", "The Terminator", "When Harry Met Sally"
