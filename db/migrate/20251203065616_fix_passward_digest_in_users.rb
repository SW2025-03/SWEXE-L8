class FixPasswardDigestInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :passward_digest, :password_digest
  end
end
