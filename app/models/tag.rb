class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
end
