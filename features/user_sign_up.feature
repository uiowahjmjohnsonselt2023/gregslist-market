Feature: Sign up as a new user

  As a Guest
  So that I can start buying items
  I want to sign up as a new user on the website

  Scenario: see the landing page with welcome messages
    Given I am on signup page
    When I fill in "username" with "thefirstuser"
    Then I should see "Welcome to gregslist-market"