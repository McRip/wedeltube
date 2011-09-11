require 'spec_helper'

describe Video do

  before(:each) { @userAttr = {
      :username => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :confirmed_at => "2011-09-11 10:00:00" } }

  it "should create a valid Video" do
   temp_user = User.new(@userAttr)
   temp_user.should be_valid
   temp_file = File.new(Rails.root + 'spec/test_files/Frau.avi')
   Video.new(:title => "Video", :user => temp_user, :video => temp_file).should be_valid
  end
end