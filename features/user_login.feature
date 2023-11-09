Feature: User login and logout

  As a User
  So that I can confirm that I log in as myself
  I want to see my profile

Background: users have been added to database
  Given the following users exist:
  |user|password|email|
  |selt_team8| regularMeeting0204 |seltteamproject@gmail.com|
  |snoopylover| the1stcutiestdog |sslocdg@gmail.com|
  |catman| catsownmyworld22 |amandacat0912@gmail.com|


  Scenario: see the belonged profile after log in
    When I log in as "catman"
    And I am on my profile page
    Then I should see my user information

  Scenario: edit my profile after log in
    When I log in as "catman"
    And I am on my profile page
    And I edit my address
    Then I should see my new address

  Scenario: log out
    When I log out
    Then I should not be on my profile page
    And I should be on the home page