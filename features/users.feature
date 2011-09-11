Feature: User Actions

  Background:
    Given I am a user named "foo" with an email "user@test.com" and password "please"
    Then I confirm my account with email "user@test.com"
    And I sign out

    Scenario: View Users as stranger
      When I go to the users index page
      Then I should be on the sign in page
      And I should see "Du musst dich anmelden oder einloggen um fortzufahren."
      
    Scenario: View Users as logged in User
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I go to the users index page
      Then I should see "Benutzerübersicht"
      When I follow "F"
      Then I should see "foo"
      When I follow "foo"
      Then I should be on the user profile page for "foo"