class ChangeStatusToStringInParticipations < ActiveRecord::Migration[8.0]
  def change
    change_column :participations, :status, :string
  end
end


