require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = Factory(:user)
    @admin = Factory(:admin)
    sign_in @admin
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @user.id
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end

  end

  describe "DELETE 'destroy'" do

    it "should be not successful" do
      delete :destroy, :id => @user.id
      response.should_not be_success
    end

    #it "should be successful" do
      #delete :destroy, :id => @user.id
      #response.should be_success
    #end

  end

end