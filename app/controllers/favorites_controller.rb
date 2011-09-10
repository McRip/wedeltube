class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_favorite, :except => [ :create_favindex, :create_detail, :index ]

  def index
    @favorites = User.find(params[:user_id]).favorites
  end

  def create_favindex
    create params[:video]
    respond_to do |format|
      format.html {
        redirect_to user_favorites_url(current_user)
      }
      format.js {
        render :partial => "favheart", :locals => { :video => @favorite.video } and return
      }
    end
  end

  def create_detail
    create params[:video]
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

  def destroy_favindex
    @favorite.destroy
    respond_to do |format|
      format.html {
        redirect_to video_url(@favorite.video)
      }
      format.js {
        render :partial => "favheart", :locals => { :video => @favorite.video } and return
      }
    end
  end

  def destroy_detail
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

  def create videoparams
    @favorite = Favorite.find_by_video_id_and_user_id(Video.find(videoparams).id, current_user.id)
    unless @favorite.present?
      @favorite = Favorite.new
      @favorite.video = Video.find videoparams
      @favorite.user = current_user
      @favorite.save
    end
  end

  def find_favorite
    @favorite = Favorite.find params[:id]
  end
end
