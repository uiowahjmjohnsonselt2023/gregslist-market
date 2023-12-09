Feature: Add items into my cart as a buyer

  As a buyer
  So that I can check out for the items I want later
  I want to add those items into my cart

  Background: users and items have been added to database
    Given the following users exist
      | name    | username   | password | email                 | activated |
      | John    | john_doe   | password | john.doe@example.com  | true      |
      | Alice   | alice_sm   | secret   | alice.sm@example.com  | true      |
      | Louis   | Louis1207  | secret   | louis1207@example.com | true      |
      | Mandy   | mandy_doe  | password | mandy.doe@example.com | true      |

    And the following buyers exist
      | first name     | last name  | address      | payment method | user id |
      | Louis          | Ken        | 300 road, IA | VISA           | 3       |
      | John           | Doe        | 301 road, IA | VISA           | 1       |
      | Mandy          | Doe        | 301 road, IA | Master         | 4       |

    And the following stores exist
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

  Scenario: See items on sale as a buyer
    Given I am on the homepage
#    And I log in with email "john.doe@example.com" and password "password"
#    Then I should be on the homepage
    Then I should see all the items
#    When I add "Sunglasses" sold by "Cindy 1st" to my cart
#    And I should see "Item added to cart."

  Scenario: Add an item into the cart
    Given I am on the login page
    And I log in with email "john.doe@example.com" and password "password"
    And I am on the homepage
#    When I add
#    When I complete the product post form
#    Then I should see my product in my store