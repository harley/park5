class CreateBlockedFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :blocked_friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
