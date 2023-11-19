Feature: Access seller accounts

  As a User
  So that I can begin selling items
  I want to access my sellers

  Background: stores have been added to database
    Given the following users exist
      | name    | username   | password | email                 |
      | Cindy   | cindy_doe  | password | cindy.doe@example.com |
      | Alice   | alice_sm   | secret   | alice.sm@example.com  |
    And the following stores exist
      | name            | description  | address      |
      | Cindy 1st       | 1 store      | 100 road, IA |
      | Cindy 2nd       | 2 store      | 101 road, IA |

    And the following associations exist
      | user_id    | seller_id  |
      | 1          | 1          |
      | 1          | 2          |


  Scenario: create a new seller account
    Given I am on the login page
    When I log in with email "alice.sm@example.com" and password "secret"
    And I should be on my profile page
    When I want to access my seller account
    And I don't have existing seller account yet
    When I complete the seller edit form
    Then I should be on the store page

  Scenario: access an existing seller account
    Given I am on the login page
    When I log in with email "cindy.doe@example.com" and password "password"
    And I should be on my profile page
    When I want to access my seller account
    Then I should see all my existing seller accounts
#    When I select the seller account with the name "Cindy 1st"
#    Then I should be on the store page




