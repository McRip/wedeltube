class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :except => [:index, :new, :create]
  
  def index
    @users = User.paginate :page => params[:page], :conditions => ["username LIKE ?", params[:start_letter].present? ? params[:start_letter]+"%" : "A%"]
  end

  def show
    
  end

  def destroy  
    if current_user.is_admin? 
      if @users.destroy
        redirect_to users_url
      else
        render :new
      end
    else
      flash[:error] = "Funktion nicht erlaubt"
      redirect_to user_url(@users)
    end
  end


  private

  def find_user
    @user = User.find params[:id]
  end
end
