Feature: Users update their information

  As a User
  So that I can keep my latest information on the website
  I want to update my information

  Background: users have been added to database
    Given the following users exist
      | name    | username   | password | email                | activated |
      | John    | john_doe   | password | john.doe@example.com | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com | true      |

  Scenario: Delete the user's own account
    Given I am on the login page
    When I log in with email "john.doe@example.com" and password "password"
    And I want to update my user information
    And I complete the update form
    Then I should see "Profile updated"