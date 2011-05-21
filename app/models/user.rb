class User < ActiveRecord::Base

  has_many :videos
  has_many :comments
  has_many :favorites
  has_many :participants

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :name, :firstname, :email, :password, :password_confirmation, :remember_me

  acts_as_tagger
  has_friendly_id :username, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
end
