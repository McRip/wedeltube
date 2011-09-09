class Video < ActiveRecord::Base
  include ActiveRecord::Transitions

  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :participants

  scope :recent, :order => "created_at DESC", :limit => 5
  scope :popular, :select => 'videos.*, count(favorites.id) as favorites_count', :joins => 'left outer join favorites on favorites.video_id = videos.id', :group => 'videos.id', :order => "count(favorites.id) DESC", :limit => 5
  scope :most_commented, :select => 'videos.*, count(comments.id) as comments_count', :joins => 'left outer join comments on comments.video_id = videos.id', :group => 'videos.id', :order => "count(comments.id) DESC", :limit => 5
  scope :viewable, :conditions => "state = 'converted'"

  validates :title, :presence => { :message => "Bitte einen Titel eingeben" }
  validates_attachment_presence :video, :message => "Bitte Video angeben"
  validates_attachment_content_type :video, :content_type => /video\/.*/, :message => "Datei ist kein Video"

  acts_as_rateable
  acts_as_taggable
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  has_attached_file :video,
                    :styles => {
                      :ogg_360  => { :video => true, :format => "ogv", :size => "640x360"  },
                      :ogg_480  => { :video => true, :format => "ogv", :size => "854x480"  },
                      #:ogg_720  => { :video => true, :format => "ogv", :size => "1280x720" },
                      :mp4_360  => { :video => true, :format => "mp4", :size => "640x360"  },
                      :mp4_480  => { :video => true, :format => "mp4", :size => "854x480"  },
                      #:mp4_720  => { :video => true, :format => "mp4", :size => "1280x720" },
                      :webm_360 => { :video => true,:format => "webm", :size => "640x360"  },
                      :webm_480 => { :video => true,:format => "webm", :size => "854x480"  },
                      #:webm_720 => { :video => true,:format => "webm", :size => "1280x720" },
                      :thumb6400 => { :thumbnail => true, :format => "jpg", :index => 1, :size => "640x360" },
                      :thumb6401 => { :thumbnail => true, :format => "jpg", :index => 2, :size => "640x360" },
                      :thumb6402 => { :thumbnail => true, :format => "jpg", :index => 3, :size => "640x360" },
                      :thumb6403 => { :thumbnail => true, :format => "jpg", :index => 4, :size => "640x360" },
                      :thumb8540 => { :thumbnail => true, :format => "jpg", :index => 1, :size => "854x480" },
                      :thumb8541 => { :thumbnail => true, :format => "jpg", :index => 2, :size => "854x480" },
                      :thumb8542 => { :thumbnail => true, :format => "jpg", :index => 3, :size => "854x480" },
                      :thumb8543 => { :thumbnail => true, :format => "jpg", :index => 4, :size => "854x480" },
                      :thumb1280 => { :thumbnail => true, :format => "jpg", :index => 1, :size => "128x72" },
                      :thumb1281 => { :thumbnail => true, :format => "jpg", :index => 2, :size => "128x72" },
                      :thumb1282 => { :thumbnail => true, :format => "jpg", :index => 3, :size => "128x72" },
                      :thumb1283 => { :thumbnail => true, :format => "jpg", :index => 4, :size => "128x72" },
                      :thumb2660 => { :thumbnail => true, :format => "jpg", :index => 1, :size => "266x150" },
                      :thumb2661 => { :thumbnail => true, :format => "jpg", :index => 2, :size => "266x150" },
                      :thumb2662 => { :thumbnail => true, :format => "jpg", :index => 3, :size => "266x150" },
                      :thumb2663 => { :thumbnail => true, :format => "jpg", :index => 4, :size => "266x150" }
                    },
                    :processors => [:ffmpeg]

  before_post_process Proc.new { 
    begin 
      self.convert! 
    rescue Exception
    end
  }
  after_post_process Proc.new { 
    begin 
      self.converted! 
    rescue Exception
    end 
  }
  process_in_background :video

  state_machine do
    state :pending
    state :converting
    state :converted
    state :error

    event :convert do
      transitions :from => :pending, :to => :converting
    end

    event :converted do
      transitions :from => :converting, :to => :converted
    end

    event :failed do
      transitions :from => :converting, :to => :error
    end
  end

  def self.top_rated
    self.find(:all).sort_by{|video| video.average_rating}.take(5)
  end

  def to_s
    self.title
  end
  
  def is_favorite_of?(user)
    favorite = self.favorites.find_by_user_id(user.id)
    favorite.present? ? favorite : false
  end
end
