Feature: Sign up as a new user

  As a Guest
  So that I can start buying items
  I want to sign up as a new user on the website

  Scenario: see the filling blocks for signing up
    Given I am on the user signup page
    Then I should see the field for "name"
    And I should see the field for "user_username"
    And I should see the field for "user_password"
    And I should see the field for "user_email"

  Scenario: be able to register
    Given I am on the user signup page
    When I complete the signup form
    And I activate my account
    And I log in with the information
    Then I should see my profile

