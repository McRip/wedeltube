require 'spec_helper'

describe ParticipantsController do

  before (:each) do
    @user = Factory(:admin)
    @video = Factory(:video, :user => @user)
    @participant = Factory(:participant, :user => @user, :video => @video, :name => @user.name, :role => "Kamera")
    sign_in @user
  end



  describe "DELETE 'destroy'" do

    #it "should be successful" do
      #delete :destroy, :id => @participant.id
      #response.should be_success
    #end

  end

end