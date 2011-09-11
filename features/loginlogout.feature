Feature: Account Management
  In order to get access and to use the site
  A user
  Should be able to sign in, sign out, register etc.

  Scenario: User is not signed up
    Given I am not logged in
    And no user exists with an email of "user@wedeltube.com"
    When I go to the sign in page
    And I sign in as "user@test.com/please"
    Then I should see "Unbekannte E-Mail oder ungültiges Passwort."
    And I go to the home page
    And I should be signed out

  Scenario: User signs out
    Given I am a user named "foo" with an email "user@test.com" and password "please"
    Then I confirm my account with email "user@test.com"
    When I sign in as "user@test.com/please"
    Then I should be signed in
    And I sign out
    Then I should be signed out
    When I return next time
    Then I should be signed out