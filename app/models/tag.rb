class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy

  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german, :allow_nil => true

  def to_s
    self.name
  end
end
