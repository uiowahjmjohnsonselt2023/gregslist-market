Feature: Admin manage unqualified users

  As a Admin
  So that I can manage users on the platform
  I want to be able to delete a user account

  Background: users have been added to database
    Given the following users exist
      | name    | username   | password | email                 |
      | John    | john_doe   | password | john.doe@example.com  |
      | Alice   | alice_sm   | secret   | alice.sm@example.com  |
      | Kevin   | kevin_pjk  | ksecret  | kevin.pjk@example.com |
      | Emily   | emily_em   | esecret  | emily.em@example.com  |
    And I am on the admin page
    Then 4 users should exist

  Scenario: Delete a user
    When I am on the admin page
    And I delete the user whose username is "kevin_pjk"
    Then I should see the following usernames on the users list: "john_doe","alice_sm","emily_em"
    Then I should not see "kevin_pjk" on the users list

