Feature: Sign up as a new seller

  As a Guest
  So that I can begin selling items
  I want to sign up as a seller

  Scenario: see the filling blocks for signing up
    Given I am on the user signup page
    Then I should see the field for "name"
    And I should see the field for "user_username"
    And I should see the field for "user_password"
    And I should see the field for "user_email"

  Scenario: be able to register as a seller
    Given I am on the user signup page
    And I want to apply as a seller
    When I complete the signup form
    Then I should see my profile