class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_video, :except => [ :index, :new, :create ]

  def index
    @videos = Video.paginate :page => params[:page]
  end

  def show
    
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    @video.user = current_user
    @video.save
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
