require 'spec_helper'

describe ParticipantsController do

  before (:each) do
    @user = Factory(:admin)
    @video = Factory(:video, :user => @user)
    @participant = Factory(:participant, :user => @user, :video => @video, :name => @user.name, :role => "Kamera")
    sign_in @user
  end


  describe "DELETE 'destroy'" do

    it "should be successful" do
      delete :destroy, :id => @participant.id, :user_id => @participant.user_id, :video_id => @participant.video_id
      response.should be_success
    end
    
  end


  describe "POST 'create'" do

    it "should be successful" do
      post :create, :user_id => @participant.user_id, :video_id => @participant.video_id
      response.should be_success
    end

    it "should find the right user" do
      post :create, :video_id => @participant.video_id, :user_id => @participant.user_id
      assigns[:participant].should == @participant
    end

  end


  describe "PUT 'update'" do

    it "should be successful" do
      put :update, :participant => { :id => "1", :video_id => "1", :user_id => "2" }
      response.should be_success
    end


  end
  
end