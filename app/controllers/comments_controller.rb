class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_comment, :except => [ :create ]

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.video = Video.find params[:video_id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to video_url(@comment.video) }
        format.js { render @comment }
      else
        format.html { redirect_to video_url(@comment.video) }
        format.js { render :partial => "form", :status => 403 }
      end
    end
  end

  def update
    @comment.update_attributes(params[:comment])
    render @comment
  end

  def destroy
    @video = @comment.video
    if current_user.is_admin? || current_user.owns_video?(@video)
      if @comment.destroy
        redirect_to @video
      else
        render :new
      end
    else
      flash[:error] = "Funktion nicht erlaubt"
      redirect_to @video
    end
  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end
end
