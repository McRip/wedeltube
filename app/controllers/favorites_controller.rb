class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_favorite

  def create

  end

  def update

  end

  def destroy

  end

  private

  def find_favorite
    Favorite.find params[:id]
  end
end
