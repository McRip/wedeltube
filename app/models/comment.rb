class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  has_many :reports, :as => :reportable

  validates :comment, :presence => { :message => "Bitte einen Kommentar eingeben" }
end
