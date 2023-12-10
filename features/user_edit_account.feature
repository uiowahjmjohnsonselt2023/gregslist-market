Feature: Users delete their own accounts

  As a User
  So that I can prevent my information from being leaked
  I want to delete my account once I no longer want to

  Background: users have been added to database
    Given the following users exist
      | name    | username   | password | email                | activated |
      | John    | john_doe   | password | john.doe@example.com | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com | true      |

  Scenario: Delete the user's own account
    Given I am on the login page
    When I log in with email "john.doe@example.com" and password "password"
    And I delete my account
    Then I should be on the homepage
    And I should see "The account is deleted."