Feature: Access seller accounts

  As a User
  So that I can begin selling items
  I want to access my sellers

  Background: stores have been added to database
    Given my following stores exist
      | name                | description         | address                               |
      | Cindy's store       | the first one       | 26 E Market St, Iowa City, IA 52245   |
      | Cindy's 22 store    | the second one      | 29 E Market St, Iowa City, IA 52245   |

    And the following users exist
      | name    | username   | password | email                |
      | Cindy   | cindy_doe  | password | cindy.doe@example.com |
      | Alice   | alice_sm   | secret   | alice.sm@example.com |

  Scenario: access an existing seller account
    Given I am on my profile page
    When I want to access my seller account
    Then I should see my existing seller accounts
    When I select one of my seller account
    Then I should see my store's name


  Scenario: create a new seller account
    Given I am on my profile page
    When I want to access my seller account
    And I don't have existing seller account yet
    When I complete the seller edit form
    Then I should see my store's name