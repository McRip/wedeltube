class Video < ActiveRecord::Base
  include ActiveRecord::Transitions

  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :participants

  scope :recent, :order => "created_at DESC"
  scope :popular, :select => 'videos.*, count(favorites.id) as favorites_count', :joins => 'left outer join favorites on favorites.video_id = videos.id', :group => 'videos.id'
  scope :most_commented, :select => 'videos.*, count(comments.id) as comments_count', :joins => 'left outer join comments on comments.video_id = videos.id', :group => 'videos.id'

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
                      :thumb0 => { :thumbnail => true, :format => "jpg", :index => 1, :size => "854x480" },
                      :thumb1 => { :thumbnail => true, :format => "jpg", :index => 2, :size => "854x480" },
                      :thumb2 => { :thumbnail => true, :format => "jpg", :index => 3, :size => "854x480" },
                      :thumb3 => { :thumbnail => true, :format => "jpg", :index => 4, :size => "854x480" }
                    },
                    :processors => [:ffmpeg]

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

  def to_s
    self.title
  end

  def is_favorite_of?(user)
    favorite = self.favorites.find_by_user_id(user.id)
    favorite.present? ? favorite : false
  end
end
