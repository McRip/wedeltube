Feature: Participants Actions

  Background:
    Given a Video exists
    Given I am on the show page
    
    Scenario: Creating a Participant
      When I follow "Teilnehmer hinzufügen"
      Then I should see "Filmmitarbeiter hinzufügen"
      When I fill in "Teilnehmer" with "Hugo"
      And I check "Licht"
      Then I should not see "Error"
      When I check "Kamera"
      Then the "Kamera" checkbox should be checked
      When I uncheck "Kamera"
      Then the "Kamera" checkbox should be unchecked

    Scenario: Deleting a Participant
      When I follow "Mitarbeiter löschen"
      Then I should not see "Participant"
      
      
