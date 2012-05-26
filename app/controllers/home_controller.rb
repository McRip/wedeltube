class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [:index, :home]

  def index
    @new_videos = Video.viewable.recent
    @popular_videos = Video.viewable.popular
    @most_commented_videos = Video.viewable.most_commented
    @most_viewed_videos = Video.viewable.most_viewed
  end

  def home
    
  end
  
  def imprint
    
  end
end
