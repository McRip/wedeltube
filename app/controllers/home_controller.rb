class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [ :home ]

  def index
    @new_videos = Video.recent
    @popular_videos = Video.popular
    @most_commented_videos = Video.most_commented
    @most_viewed_videos = Video.most_viewed
  end

  def home
    
  end
end
