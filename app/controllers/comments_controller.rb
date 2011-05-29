class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_comment, :except => [ :create ]

  def create
    @comment = Comment.new(params[:comment])
    render @comment
  end

  def update
    @comment.update_attributes(params[:comment])
    render @comment
  end

  def destroy
    @video = @comment.video
    @comment.destroy
    redirect_to @video
  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end
end
