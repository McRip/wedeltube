class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => [ :home ]

  def index
    
  end

  def home
    
  end
end
