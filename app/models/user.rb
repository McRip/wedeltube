class User < ActiveRecord::Base

  has_many :videos
  has_many :comments
  has_many :favorites
  has_many :participants

  validates :username, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :name, :firstname, :email, :password, :password_confirmation, :remember_me, :avatar

  acts_as_tagger
  has_friendly_id :email, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  has_attached_file :avatar, :styles => { :medium => "300x300>", 
                                          :profile => "200x200>",
                                          :thumb => "100x100>",
                                          :square50 => "50x50#",
                                          :square100 => "100x100#" }, :default_url => '/images/missing_:style.png'

  def to_s
    self.username
  end
  
  def is_admin?
    self.admin.present?
  end

  def owns_video?(video)
    self.videos.include?(video)
  end

  def has_favorite_video?(video)
    favorite = self.favorites.find_by_video_id(video.id)
    favorite.present? ? favorite : false
  end
end
