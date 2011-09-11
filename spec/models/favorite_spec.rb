require 'spec_helper'

describe Favorite do

  @userAttr = {
      :username => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :confirmed_at => "2011-09-11 10:00:00"
    }

  it "should create a valid Favorite" do
    def_user = User.new(@attr)
    def_video = Video.new()
    Favorite.new(:user => def_user, :video => def_video).should be_valid
  end

end