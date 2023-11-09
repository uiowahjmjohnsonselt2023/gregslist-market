Feature: Sign up as a new user

  As a Guest
  So that I can start buying items
  I want to sign up as a new user on the website

  Scenario: see the filling blocks for signing up
    Given I am on the user signup page
    Then I should see the field for "username"
    And I should see the field for "password"
    And I should see the field for "email address"

  Scenario: be able to sign up
    Given I am on the user sign-up page
    When I complete the signup form
    Then I should be registered as a new user
