class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :except => [:index, :new, :create]
  
  def index
    @users = User.paginate :page => params[:page], :conditions => ["username LIKE ?", params[:start_letter].present? ? params[:start_letter]+"%" : "A%"]
  end

  def show
    
  end

  private

  def find_user
    @user = User.find params[:id]
  end
end
