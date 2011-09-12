require 'spec_helper'

describe VideosController do

  before (:each) do
    @user = Factory(:user)
    @video = Factory(:video, :user => @user)
    sign_in @user
  end

  describe "GET 'show'" do

    it "should find the right video" do
        get :show, :id => @video.id
        assigns(:video).should == @video
    end

  end

  describe "PUT 'update'" do
    it "should correctly update the video" do
        put :update, :video => {:id => "3", :title => "test", :description => "Test-Description"}
        response.should be_success
    end

  end

  describe "DELETE 'destroy'" do

    it "should not be successful" do
      delete :destroy, :id => @video.id
      response.should_not be_success
    end

    #it "should be successful" do
      #@admin = Factory(:admin)
      #sign_in @admin
      #delete :destroy, :id => @video.id
      #response.should be_success
    #end

  end

end