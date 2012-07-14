class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.references :user
      t.text :comment
      t.integer :reportable_id
      t.string :reportable_type
      t.boolean :viewed
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
