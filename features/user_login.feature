Feature: User login and logout

  As a User
  So that I can confirm that I log in as myself
  I want to see my profile

  Background: users have been added to database
    Given the following users exist
    | name    | username   | password | email                |
    | John    | john_doe   | password | john.doe@example.com |
    | Alice   | alice_sm   | secret   | alice.sm@example.com |

  Scenario: Login as John
    Given I am on the login page
    When I log in with email "john.doe@example.com" and password "password"
    Then I should see my name "John"


  Scenario: Login as Alice
    Given I am on the login page
    When I log in with email "alice.sm@example.com" and password "secret"
    Then I should see my name "Alice"

