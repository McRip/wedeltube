class TaggingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_tagging, :except => [:index]

  def create

  end

  def update

  end

  def destroy

  end

  private

  def find_tagging
    @tag = Tagging.find params[:id]
  end
end
