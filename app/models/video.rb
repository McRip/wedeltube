class Video < ActiveRecord::Base
  include ActiveRecord::Transitions

  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :participants

  acts_as_rateable
  acts_as_taggable
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  has_attached_file :video,
                    :styles => {
                      :ogg_320  => { :video => true, :format => "ogv", :size => "320x240"  },
                      :ogg_480  => { :video => true, :format => "ogv", :size => "480x320"  },
                      :ogg_720  => { :video => true, :format => "ogv", :size => "1280x720" },
                      :mp4_320  => { :video => true, :format => "mp4", :size => "320x240"  },
                      :mp4_480  => { :video => true, :format => "mp4", :size => "480x320"  },
                      :mp4_720  => { :video => true, :format => "mp4", :size => "1280x720" },
                      :webm_320 => { :video => true,:format => "webm", :size => "320x240"  },
                      :webm_480 => { :video => true,:format => "webm", :size => "480x320"  },
                      :webm_720 => { :video => true,:format => "webm", :size => "1280x720" },
                      :thumb0 => { :thumbnail => true, :format => "jpg", :index => 1, :size => "300x300" },
                      :thumb1 => { :thumbnail => true, :format => "jpg", :index => 2, :size => "300x300" },
                      :thumb2 => { :thumbnail => true, :format => "jpg", :index => 3, :size => "300x300" },
                      :thumb3 => { :thumbnail => true, :format => "jpg", :index => 4, :size => "300x300" }
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
end
