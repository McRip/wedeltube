Feature: Video
  In order to view videos
  an user
  wants to upload videos, view videos and
  performs several actions on those videos

  Background:
    Given I am a user named "foo" with an email "user@test.com" and password "please"
    Then I confirm my account with email "user@test.com"
    And I upload a new video

    Scenario: Upload a video
      When I upload a new video
      And I go to the new video page
      Then I should see "Testvideo"

    Scenario: View a video
      When I go to the new video page
      Then I should see "Testvideo"

    Scenario: View Video in 480 resolution

    Scenario: Add Comment   