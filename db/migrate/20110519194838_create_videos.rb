class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.references :user
      t.string :title
      t.text :description
      t.integer :views
      t.datetime :last_view
      t.integer :size
      t.integer :length
      t.integer :width
      t.integer :height
      t.string :format
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
