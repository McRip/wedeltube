class Video < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  has_many :favorites

  acts_as_rateable
  acts_as_taggable
end
