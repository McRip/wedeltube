require 'spec_helper'

describe Participant do

  before(:each) { @userAttr = {
      :username => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :confirmed_at => "2011-09-11 10:00:00" } }

  it "should create a valid Participant" do
   temp_user = User.new(@userAttr)
   temp_user.should be_valid
   Participant.new(:name => "Test", :user => temp_user, :role => "Licht").should be_valid
  end
end