class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_comment

  def create

  end

  def update

  end

  def destroy

  end

  private

  def find_comment
    @comment = Comment.find params[:id]
  end
end
