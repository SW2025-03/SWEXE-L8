class CreateParticipations < ActiveRecord::Migration[8.0]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.text :comment
      t.timestamps
    end
    add_index :participations, [ :user_id, :event_id ], unique: true
  end
end
