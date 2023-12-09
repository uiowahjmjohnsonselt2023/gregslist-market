Feature: Search for an item

  As a Guest
  So that I can see if there is the special item I am interested in
  I want to search for the special item

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

  Scenario: Search an item with its full name
    Given I am on the homepage
    When I search for "Sunglasses"
    Then I should see 1 result in term of items
    And I should not see any result in term of sellers

  Scenario: Search an item with its partial name
    Given I am on the homepage
    When I search for "Sun"
    Then I should see 1 result in term of items
    And I should not see any result in term of sellers

  Scenario: Search a seller with its full name
    Given I am on the homepage
    When I search for "Cindy 1st"
    Then I should see 1 result in term of sellers
    And I should not see any result in term of items

  Scenario: Search a seller with its partial name
    Given I am on the homepage
    When I search for "Cindy"
    Then I should see 2 result in term of sellers
    And I should not see any result in term of items