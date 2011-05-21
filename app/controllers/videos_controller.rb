class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_video, :except => [ :index ]

  def index
    @videos = Video.paginage :page => params[:page]
  end

  def show
    
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def find_video
    @video = Video.find params[:id]
  end
end
