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
                    :styles => { :ogg => ["1280x720", "640x480", "320x240"],
                                 :mp4 => ["1280x720", "640x480", "320x240"],
                                 :webm => ["1280x720", "640x480", "320x240"],
                                 :preview1 => "300x300>",
                                 :review2 => "300x300>",
                                 :preview3 => "300x300>",
                                 :preview4 => "300x300>" },
                    :processors => [:video_processor, :video_thumbnail_processor]

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
