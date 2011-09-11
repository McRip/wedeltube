require 'spec_helper'

describe Favorite do

  before(:each) { @userAttr = {
      :username => "Example User5",
      :email => "user5@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :confirmed_at => "2011-09-11 10:50:00" } }

  it "should create a valid Favorite" do
    temp_user = User.new(@userAttr)
    temp_user.should be_valid
    temp_file = File.new(Rails.root + 'spec/test_files/Frau.avi')
    temp_video = Video.new(:title => "Video", :user => temp_user, :video => temp_file)
    temp_video.should be_valid
    Favorite.new(:user => temp_user, :video => temp_video).should be_valid
  end

end