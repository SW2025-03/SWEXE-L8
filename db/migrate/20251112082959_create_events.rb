class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :capacity
      t.string :category
      t.string :organizer
      t.string :thumbnail_url
      t.boolean :is_public
      t.integer :creator_id

      t.timestamps
    end
  end
end
