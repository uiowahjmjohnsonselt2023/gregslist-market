Feature: Admin manage unqualified products

  As a Admin
  So that I can ensure only permitted products are sold
  I want to be able to delete a prohibited or illegal product

  Background: products have been added to database
    Given the following products exist
      | name                                            | price      | date        | category | seller_username |
      | Sunglasses                                      | 25.7       | 2023-10-31  | Fashion  | Alice           |
      | Modern Computer Organization and Architecture   | 70         | 2022-05-22  | Books    | Jack            |
      | Lover                                           | 39.99      | 2021-01-01  | Music    | Joanna          |
    And I am on the admin page
    Then 3 products should exist

  Scenario: Delete a product
    When I am on the admin page
    And I delete the product "Sunglasses"
    Then I should see the following products on the products list: "Modern Computer Organization and Architecture","Lover"
    Then I should not see "Sunglasses" on the products list
    And 2 products should exist