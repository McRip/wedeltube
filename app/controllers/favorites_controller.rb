class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_favorite, :except => [ :create ]

  def create
    @favorite = Favorite.new(params[:favorite])
    @favorite.save
  end

  def update
    @favorite.update_attributes(params[:favorite])
  end

  def destroy
    @favorite.destroy
  end

  private

  def find_favorite
    @favorite = Favorite.find params[:id]
  end
end
