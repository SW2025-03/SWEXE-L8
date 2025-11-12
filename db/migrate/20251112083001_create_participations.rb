class CreateParticipations < ActiveRecord::Migration[8.0]
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end
end
