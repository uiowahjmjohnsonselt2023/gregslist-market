Feature: Sign up as a buyer

  As a User
  So that I can start buying items
  I want to edit my information which is necessary before making a purchase

  Background: users have been added to database
    Given the following users exist
    | name    | username   | password | email                | activated |
    | John    | john_doe   | password | john.doe@example.com | true      |
    | Alice   | alice_sm   | secret   | alice.sm@example.com | true      |

  Scenario: see the filling blocks for signing up
    Given I am on the buyer edit page
    Then I should see the field for "First name"
    And I should see the field for "Last name"
    And I should see the field for "Address"
    And I should see the field for "Payment method"


  Scenario: be able to update the information
    Given I am on the login page
    And I log in with email "john.doe@example.com" and password "password"
    And I am on the buyer edit page
    When I complete the edit form
    Then I should be on my profile page
#    Then I should see my address and payment method