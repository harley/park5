class BlockedFriend < ApplicationRecord
  belongs_to :user
	belongs_to :friend, class_name: 'User'
	validates :user_id, uniqueness: { scope: [:user_id, :friend_id] }
end
