Feature: Seller Signup

  As a User
  So that I can begin selling items
  I want to sign up as a seller


  Scenario: be able to sign up as seller
    Given I am on the user signup page
    When I check the "As a seller" checkbox
    And I complete the signup form
    Then I should be a valid seller