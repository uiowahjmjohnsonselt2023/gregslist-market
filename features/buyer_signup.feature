Feature: Sign up as a buyer

  As a User
  So that I can start buying items
  I want to edit my information which is necessary before making a purchase

  Scenario: see the filling blocks for signing up
    Given I am on the buyer edit page
    Then I should see the field for "address"
    And I should see the field for "payment"


  Scenario: be able to update the information
    Given I am on the buyer edit page
    When I complete the edit form
    And I am on my profile page
    Then I should see my address and payment method