class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :comment, :presence => { :message => "Bitte einen Kommentar eingeben" }
end
