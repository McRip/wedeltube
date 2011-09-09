class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_video, :except => [ :index, :new, :create ]

  def index
    @videos = Video.paginate :page => params[:page]
  end

  def show
    @resolution = build_resolution_hash (params[:res] || "360")
    @comment = @video.comments.new
    @participant = @video.participants.new
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    @video.user = current_user
    @video.thumb_index = 1
    if @video.save
      redirect_to @video
    else
      render :new
    end
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
    respond_to do |format|
      if @video.save
        format.js {
          render :text => "true"
        }
      else
        format.js {
          render :text => "false"
        }
      end
    end
    
  end

  def remove_tag
    @video.tag_list.remove(params[:tag])
    respond_to do |format|
      if @video.save
        format.js {
          render :text => "true"
        }
      else
        format.js {
          render :text => "false"
        }
      end
    end
  end

  private

  def find_video
    @video = Video.find params[:id]
  end

  def build_resolution_hash res
    case res
    when "360"
      resolution = {:name => "360", :x => "640", :y => "360"}
    when "480"
      resolution = {:name => "480", :x => "854", :y => "480"}
    when "720"
      resolution = {:name => "720", :x => "1280", :y => "720"}
    end
    resolution
  end
end
