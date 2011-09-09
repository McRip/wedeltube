class AddVideoThumbIndexToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :thumb_index, :integer
  end

  def self.down
    remove_column :videos, :thumb_index, :integer
  end
end
