Feature: User reset password

  As a User
  So that I can login to my account even though I forget my password
  I want to reset my password

  Background: users have been added to database
    Given the following users exist
      | name    | username   | password | email                | activated |
      | John    | john_doe   | password | john.doe@example.com | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com | true      |

  Scenario: Login as John without remembering the correct password
    Given I am on the login page
    When I log in with email "john.doe@example.com" and forget my password
#    Then I should be on the homepage
#    And I should see "Email sent with password reset instructions"
    And I check out the email
    Then I am on the reset password page
    And I enter my new password
    Then I should be on my profile page
    And I should see "Password has been reset."
