class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_video, :except => [ :index, :new, :create ]

  def index
    @videos = Video.paginate :page => params[:page]
  end

  def show
    @resolution = build_resolution_hash (params[:res] || "320")
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    @video.user = current_user
    @video.save
    redirect_to @video
  end

  def edit
  end

  def update
    @video.update_attributes(params[:video])
    redirect_to @video
  end

  def destroy
    @video.destroy
    redirect_to videos_path
  end

  def add_tag
    @video.tag_list.add(params[:tag])
    @video.save
    redirect_to @video
  end

  def remove_tag
    @video.tag_list.remove(params[:tag])
    @video.save
    redirect_to @video
  end

  private

  def find_video
    @video = Video.find params[:id]
  end

  def build_resolution_hash res
    case res
    when "320"
      resolution = {:name => "320", :x => "320", :y => "240"}
    when "480"
      resolution = {:name => "480", :x => "480", :y => "320"}
    when "720"
      resolution = {:name => "720", :x => "1280", :y => "720"}
    end
    resolution
  end
end
