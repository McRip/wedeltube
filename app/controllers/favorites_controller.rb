class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_favorite, :except => [ :create, :index ]

  def index
    @favorites = User.find(params[:user_id]).favorites
  end

  def create
    @favorite = Favorite.new
    @favorite.video = Video.find params[:video]
    @favorite.user = current_user
    @favorite.save
    respond_to do |format|
      format.html {
        redirect_to video_url(@favorite.video)
      }
      format.js {
        render :partial => "videos/favorites", :locals => { :video => @favorite.video } and return
      }
    end
  end

  def update
    @favorite.update_attributes(params[:favorite])
  end

  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html {
        redirect_to video_url(@favorite.video)
      }
      format.js {
        render :partial => "videos/favorites", :locals => { :video => @favorite.video } and return
      }
    end
  end

  private

  def find_favorite
    @favorite = Favorite.find params[:id]
  end
end
