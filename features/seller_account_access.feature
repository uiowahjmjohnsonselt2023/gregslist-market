Feature: Access seller accounts

  As a User
  So that I can begin selling items
  I want to access my sellers

  Background: stores have been added to database
    Given the following users exist
      | name    | username   | password | email                 | activated |
      | Cindy   | cindy_doe  | password | cindy.doe@example.com | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com  | true      |

    And the following stores exist
      | name            | description  | address      |
      | Cindy 1st       | 1 store      | 100 road, IA |
      | Cindy 2nd       | 2 store      | 101 road, IA |

    And the following associations between user and seller exist
      | user_id    | seller_id  |
      | 1          | 1          |
      | 1          | 2          |


  Scenario: create a new seller account
    Given I am on the login page
    When I log in with email "alice.sm@example.com" and password "secret"
    And I am on my profile page
    When I want to access my seller account
    And I don't have existing seller account yet
    When I complete the seller edit form
    Then I should be in my store

  Scenario: access an existing seller account
    Given I am on the login page
    When I log in with email "cindy.doe@example.com" and password "password"
    And I am on my profile page
    When I want to access my seller account
    Then I should see all my existing seller accounts
    When I select the seller account with the name "Cindy 2nd"
    Then I should be in my store




