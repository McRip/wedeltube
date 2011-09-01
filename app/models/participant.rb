class Participant < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates :name, :presence => { :message => "Bitte einen Namen eingeben" }
  validates :role, :presence => { :message => "Bitte mindestens einen Eintrag selektieren" }

end
