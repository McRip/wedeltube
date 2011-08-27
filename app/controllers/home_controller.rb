class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [ :home ]

  def index
    @new_videos = Video.recent :limit => 5
    @popular_videos = Video.popular :limit => 5
    @most_commented_videos = Video.most_commented :limit => 5
    @top_rated_videos = Video.top_rated
  end

  def home
    
  end
end
