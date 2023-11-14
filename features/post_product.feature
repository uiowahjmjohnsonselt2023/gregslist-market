Feature: Seller post and update products

  As a Seller
  So that I can make money
  I want to post a product for sale under a category and include its price, description and images

  Background: users have been added to database
    Given the following products exist
      | name                                            | price      | date        | category | seller_username |
      | Sunglasses                                      | 25.7       | 2023-10-31  | Fashion  | Alice           |
      | Modern Computer Organization and Architecture   | 70         | 2022-05-22  | Books    | Jack            |
      | Lover                                           | 39.99      | 2021-01-01  | Music    | Joanna          |

  Scenario: Post a product
    Given I am in the storehouse
    When I complete the product post form
    Then I should see my product in my store

  Scenario: Update the price of a product
    Given I am in the storehouse
    When I update the price of "Sunglasses" with "$20.12"
    Then I should see "Sunglasses" with "$20.12"
    And I should not see "Sunglasses" with "$25.7"


