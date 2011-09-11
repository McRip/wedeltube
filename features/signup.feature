Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

  Background:
    Given I am not logged in
    And I am on the home page
    And I go to the sign up page

    Scenario: User signs up with valid data
      And I fill in the following:
        | Benutzername          | Testy McUserton |
        | E-Mail-Adresse        | user@test.com   |
        | Kennwort              | please          |
        | Kennwort-Wiederholung | please          |
      And I press "Jetzt Registrieren"
      Then I should see "Du bist nun registriert. Allerdings konntest du nicht eingeloggt werden, da dein Benutzerkonto unconfirmed ist."

    Scenario: User signs up with invalid email
      And I fill in the following:
        | Benutzername          | Testy McUserton |
        | E-Mail-Adresse        | invalidemail    |
        | Kennwort              | please          |
        | Kennwort-Wiederholung | please          |
      And I press "Jetzt Registrieren"
      Then I should see "E-Mail-Adresse ist nicht gültig"

    Scenario: User signs up without password
      And I fill in the following:
        | Benutzername          | Testy McUserton |
        | E-Mail-Adresse        |                 |
        | Kennwort              | please          |
        | Kennwort-Wiederholung | please          |
      And I press "Jetzt Registrieren"
      Then I should see "E-Mail-Adresse muss ausgefüllt werden"

    Scenario: User signs up without password confirmation
      And I fill in the following:
        | Benutzername          | Testy McUserton |
        | E-Mail-Adresse        | user@test.com   |
        | Kennwort              | please          |
        | Kennwort-Wiederholung |                 |
      And I press "Jetzt Registrieren"
      Then I should see "Kennwort stimmt nicht mit der Bestätigung überein"

    Scenario: User signs up with mismatched password and confirmation
      And I fill in the following:
        | Benutzername          | Testy McUserton |
        | E-Mail-Adresse        | user@test.com   |
        | Kennwort              | please          |
        | Kennwort-Wiederholung | please1         |
      And I press "Jetzt Registrieren"
      Then I should see "Kennwort stimmt nicht mit der Bestätigung überein"