Feature: Seller post and update items

  As a Seller
  So that I can make money
  I want to post an item for sale under a category and include its price, description and images

  Background: items have been added to database
    Given the following stores exist
      | name            | description  | address      |
      | Cindy 1st       | 1 store      | 100 road, IA |
      | Cindy 2nd       | 2 store      | 101 road, IA |

    And the following items exist
      | name                                           | description   | listing_date | listed_price | seller_id |
      | Sunglasses                                     | Ray-ban       | 2023-10-31   | 240          | 1         |
      | Modern Computer Organization and Architecture  | ECE textbook  | 2022-05-22   | 75           | 1         |
      | Lover                                          | Taylor Swift  | 2021-01-01   | 18.99        | 2         |

    And the following categories exist
      | name            |
      | Music           |
      | Accessories     |
      | Books           |

    And the following associations between category and item exist
      | category_id | item_id |
      | 2           | 1       |
      | 3           | 2       |
      | 1           | 3       |

    And the following users exist
      | name    | username   | password | email                 | activated |
      | Cindy   | cindy_doe  | password | cindy.doe@example.com | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com  | true      |

    And the following associations between user and seller exist
      | user_id    | seller_id  |
      | 1          | 1          |
      | 1          | 2          |

  Scenario: Post an item
    Given I am in Cindy 1st as the store owner after log in with email "cindy.doe@example.com" and password "password"
    When I want to add an item
    And I complete the product post form
    Then I should see my product in my store

  Scenario: Update the price of a product from my store
    Given I am in Cindy 1st as the store owner after log in with email "cindy.doe@example.com" and password "password"
    When I update the price of "Sunglasses" with "20.12"
    Then I should see "Item updated"
    And I should not see "Sunglasses" with "25.7"


