class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :participants

  acts_as_rateable
  acts_as_taggable
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german

  def to_s
    self.title
  end
end
