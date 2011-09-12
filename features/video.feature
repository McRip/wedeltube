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
      When I follow "Videos"
      Then I should see "Hier findest du alle hochgeladenen Videos."
      When I follow "Video hochladen"
      Then I should see "Video hochladen"
      When I fill in "video_title" with "foobar"
      And I fill in "video_description" with "Nice movie"
      When I attach the file "spec/test_files/Frau.avi" to "video_video"
      And I press "video_submit"
      Then I should see "Kommentare"

    Scenario: Deleting a Video
      When I go to the video page
      And I follow "Video bearbeiten"
      And I follow "delete"
      Then I should see "Video deleted"

    Scenario: Upload a video
      When I upload a new video
      Then I should see "Testvideo"

    Scenario: View a video
      When I go to the video page
      Then I should see "Testvideo"

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

   
