Feature: User login and logout

  As a User
  So that I can confirm that I log in as myself
  I want to see my profile

Background: users have been added to database
  Given the following users exist:
  | name        | username    | password_digest                                               | email                     |
  | selt_team8  | selt_team8  | $2a$12$5VDp0vtVvTjxXwyOx3d6D.AM0/6x/rI68mXtzQQeYxC9zIyxBGzem  | seltteamproject@gmail.com |
  | snoopylover | snoopylover | $2a$12$c7aOaZ07fyRsuBbF8fG57.RBimtBwQDpNoAKSTI0qtkiJuGb9.rQG  | sslocdg@gmail.com         |
  | catman      | catman      | $2a$12$xY5/Jw2qDyjWUVfT55DPmutvnisYmdF2DZGTkzdxGSr.Y6TBSE13O  | amandacat0912@gmail.com   |


  Scenario: Login as catman
    Given I am on the login page
    When I log in with email "amandacat0912@gmail.com" and password "catsownmyworld22"
    Then I should see my name "catman"

  Scenario: Login as snoopylover
    Given I am on the login page
    When I log in with email "sslocdg@gmail.com" and password "the1stcutiestdog"
    Then I should see my name "snoopylover"

  Scenario: Login as selt_team8
    Given I am on the login page
    When I log in with email "seltteamproject@gmail.com" and password "regularMeeting0204"
    Then I should see my name "selt_team8"

  Scenario: edit my profile after log in
    Given I am on the login page
    When I log in with email "amandacat0912@gmail.com" and password "catsownmyworld22"
    And I am on my profile page
    And I edit my address
    Then I should see my new address

  Scenario: log out
    When I log out
    Then I should not be on my profile page
    And I should be on the home page