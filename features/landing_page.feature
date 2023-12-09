Feature: Landing page

  As a Guest
  So that I know the website exists
  I want to see at least a blank page

Scenario: see the landing page with welcome messages
  When I am on the home page
  Then I should see "Gregslist Marketplace"
  And I should see "The Ultimate Shopping Experience"