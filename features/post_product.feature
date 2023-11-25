Feature: Seller post and update items

  As a Seller
  So that I can make money
  I want to post a item for sale under a category and include its price, description and images

  Background: products have been added to database
    Given the following users exist
      | name    | username   | password | email                 |
      | Cindy   | cindy_doe  | password | cindy.doe@example.com |
      | Alice   | alice_sm   | secret   | alice.sm@example.com  |
    And the following stores exist
      | name            | description  | address      |
      | Cindy 1st       | 1 store      | 100 road, IA |
      | Cindy 2nd       | 2 store      | 101 road, IA |
    And the following items exist
      | name                                            | description       | seller_id  | listing_date | listed_price  |
      | Sunglasses                                      | make you cool     | 1          | 2023-10-31   | 25.30         |
      | Modern Computer Organization and Architecture   | you must need it  | 1          | 2022-05-22   | 60.99         |
      | Lover                                           | best album        | 2          | 2021-01-01   | 14.00         |
    #Then 3 items should exist

  Scenario: Post a item
    Given I log in as "cindy_doe"
    And I am at my store "Cindy 1st"
    When I want to add an item
    And I complete the item post form
    Then I should see my item in my store

  Scenario: Update the price of an item
    Given I log in as "cindy_doe"
    And I am at my store "Cindy 1st"
    When I update the price of "Sunglasses" with "20.12"
    Then I should see "Sunglasses" with "20.12"
    And I should not see "Sunglasses" with "25.30"


