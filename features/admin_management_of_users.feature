Feature: Admin manages unqualified users

  As a Admin
  So that I can manage users on the platform
  I want to be able to delete an user account

  Background: users have been added to database
    Given the following users exist
      | name       | username   | password | email                 | admin | activated |
      | Admin User | admin      | password | admin@example.com     | true  | true      |
      | John       | john_doe   | password | john.doe@example.com  | false | true      |
      | Alice      | alice_sm   | secret   | alice.sm@example.com  | false | true      |
      | Kevin      | kevin_pjk  | ksecret  | kevin.pjk@example.com | false | true      |
      | Emily      | emily_em   | esecret  | emily.em@example.com  | false | true      |

    And I log in as an admin
    Then 5 users should exist

  Scenario: Delete a user
    When I want to delete unqualified users
    And I delete the user whose name is "Kevin" and username is "kevin_pjk"
    Then I should see all the users without the deleted user
    And I should not see "kevin_pjk" on the users list

