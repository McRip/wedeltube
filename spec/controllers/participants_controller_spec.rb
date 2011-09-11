require 'spec_helper'

describe ParticipantsController do

  before (:each) do
    @user = Factory(:user)
    @video = Factory(:video)
    @participant = Factory(:participant, :user => @user, :video => @video)
    sign_in @user
  end



  describe "DELETE 'destroy'" do

    it "should be successful" do

      delete :destroy, :id => @user.participants
      response.should be_success
    end



  end

end