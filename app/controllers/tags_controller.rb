class TagsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_tag, :except => [:index]

  def index
    @tags = Tag.find(:all).delete_if{ |item| item.taggings.count == 0 }.paginate(:page => params[:page], :order => "name")
  end

  def show
    @videos = Video.tagged_with(@tag).paginate(:page => params[:page], :per_page => 12)
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
