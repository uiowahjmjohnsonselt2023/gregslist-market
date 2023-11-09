Feature: Sign up as a new user

  As a Guest
  So that I can start buying items
  I want to sign up as a new user on the website

  Scenario: see the filling blocks for signing up
    Given I am on the user signup page
    Then I should see the field for "user_name"
    And I should see the field for "user_password"
    And I should see the field for "user_email"

  Scenario: be able to sign up
    Given I am on the user signup page
    When I complete the signup form
    Then I should be a valid user
