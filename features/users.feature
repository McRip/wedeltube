Feature: User Actions

  Background:
    Given I am a user named "foo" with an email "user@test.com" and password "please"
    Then I confirm my account with email "user@test.com"
    And I sign out

    Scenario: View Users as stranger
      When I go to the users page
      Then I should be on the sign in page
      And I should see "Du musst dich anmelden oder einloggen um fortzufahren."
      
    Scenario: View Users as logged in User
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I go to the users page
      Then I should see "Benutzerübersicht"
      When I follow "F"
      Then I should see "foo"
      When I follow "foo"
      Then I should be on the user profile page for "foo"
    
    Scenario: View Profile Page as stranger
      When I go to the user profile page for "foo"
      Then I should be on the sign in page
      And I should see "Du musst dich anmelden oder einloggen um fortzufahren."

    Scenario: View Profile Page as user
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I go to the user profile page for "foo"
      Then I should see "foo"
      And I should see "Profil bearbeiten"
      And I should see "Videos dieses Benutzers"
    
    Scenario: Edit User
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I go to the user profile page for "foo"
      Then I should see "foo"
      And I should see "Profil bearbeiten"
      When I follow "Profil bearbeiten"
      Then I should see "Profil bearbeiten"
      When I fill in "Benutzername" with "bar"
      And I press "Änderungen speichern"
      Then I should see "Aktuelles Kennwort muss ausgefüllt werden"
      When I fill in "Benutzername" with "bar"
      And I fill in "Aktuelles Kennwort" with "please"
      And I press "Änderungen speichern"
      Then I should see "Dein Benutzerkonto wurde aktualisiert."
      
    Scenario: Delete User
      When I sign in as "user@test.com/please"
      Then I should be signed in
      When I go to the user profile page for "foo"
      Then I should see "foo"
      And I should see "Profil bearbeiten"
      When I follow "Profil bearbeiten"
      Then I should see "Profil bearbeiten"
      And I should see "Konto löschen"
      When I follow "Konto löschen"
      Then I should see "Auf Wiedersehen! Dein Benutzerkonto wurde gelöscht."
