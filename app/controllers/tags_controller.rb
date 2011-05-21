class TagsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_tag, :except => [:index]

  def index
    @tags = Tag.paginate params[:page]
  end

  def show
  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  def find_tag
    @tag = Tag.find params[:id]
  end
end
