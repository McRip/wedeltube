class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [ :home ]

  def index
    @new_videos = Video.recent :limit => 10
    @popular_videos = Video.popular :limit => 10
    @most_commented_video = Video.most_commented :limit => 10
    @top_rated_videos = Video.find(:all).sort_by{|video| video.average_rating}.take(10)
  end

  def home
    
  end
end
