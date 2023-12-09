Feature: Checkout my cart as a buyer

  As a buyer
  So that I can buy the items
  I want to checkout

  Background: users and items have been added to database
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

    And the following associations between item and cart exist
      | item_id    | cart_id  |
      | 1          | 1        |
      | 2          | 1        |


  Scenario: Checkout items in my cart
    Given I am on the login page
    When I log in with email "alice.sm@example.com" and password "secret"
    And I am on the homepage
    And I add "Sunglasses" sold by "Cindy 1st" to my cart
    When I want to checkout
    And I complete the checkout steps
    Then I should see my orders in the history