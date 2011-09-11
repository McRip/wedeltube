Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /^I am a user named "([^"]*)" with an email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  User.new(:username => name,
            :email => email,
            :password => password,
            :password_confirmation => password).save!
end

Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "Deine E-Mail-Adresse" with "#{email}"}
  And %{I fill in "Kennwort" with "#{password}"}
  And %{I fill in "Kennwort-Wiederholung" with "#{password}"}
  And %{I press "Jetzt Registrieren"}
  Then %{Du bist nun registriert. Allerdings konntest du nicht eingeloggt werden, da dein Benutzerkonto unconfirmed ist."}
  And %{I am logout}
end

Then /^I confirm my account with email "([^"]*)"$/ do |email|
  user = User.find_by_email(email)
  visit("/users/confirmation?confirmation_token=#{user.confirmation_token}")
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

Given /^I am logout$/ do
  Given %{I sign out}
end

Given /^I am not logged in$/ do
  Given %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "E-Mail-Adresse" with "#{email}"}
  And %{I fill in "Kennwort" with "#{password}"}
  And %{I press "Login"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Du bist nun eingeloggt."}
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Registrieren"}
  And %{I should see "Login"}
  And %{I should not see "Logout"}
end