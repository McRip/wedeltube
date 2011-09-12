Feature: Video
  In order to view videos
  an user
  wants to upload videos, view videos and
  performs several actions on those videos

  Background:
    Given I am a user named "foo" with an email "user@test.com" and password "please"
    Then I confirm my account with email "user@test.com"
    And I upload a new video
    
    Scenario: Creating a Video
      When I fill in "Title" with "foobar"
      And I fill in "Description" with "Nice movie"
      And I press "commit"
      Then I should see "Video created"

    Scenario: Deleting a Video
      When I go to the video page
      And I follow "Delete"                   
      Then I should see "Video deleted"


 Scenario: Upload an video
      When I upload a new video

    Scenario: View an video

    Scenario: View Video in 480 resolution

    Scenario: Add Comment
      When I click on "Kommentar hinzufügen"
      Then I should see "Kommentar hinzufügen"
      When I fill in "Hier ist Platz für deine Meinung" with "Hallo Hier"
      Then I should not see "Error"
      When I follow "Absenden"
      Then I should see the show page
    
    Scenario: Add Participant
      When I click on "Teilnehmer hinzufügen"
      Then I should see "Filmmitarbeiter hinzufügen"
      When I fill in "Teilnehmer" with "Hugo"
      And I check "Licht"
      Then I should not see "Error"
      When I check "Kamera"
      Then the "Kamera" checkbox should be checked
      When I uncheck "Kamera"
      Then the "Kamera" checkbox should be unchecked
      When I follow "Absenden"
      Then I should see "Teilnehmer"

    