Feature: User delete their own account

  As a User
  So that I can prevent the leakage of my personal data
  I want to delete my account after I don't want to use this website anymore

  Background: users have been added to database
    Given the following users exist
      | name    | username   | password | email                | activated |
      | John    | john_doe   | password | john.doe@example.com | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com | true      |

  Scenario: John deletes his own account
    Given I am on the login page
    When I log in with email "john.doe@example.com" and password "password"
    Then I should be on my profile page