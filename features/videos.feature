Feature: Video Actions

  Background:
    Given I go to the new video page
    Given a Video exists

    Scenario: Creating a Video
      When I fill in "Title" with "foobar"
      And I fill in "Description" with "Nice movie"
      And I press "commit"
      Then I should see "Video created"

    Scenario: Deleting a Video
      When I go to the video page
      And I follow "Delete"                   
      Then I should see "Video deleted"


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
      Then I should see "asdasd"
