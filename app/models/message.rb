class Message < ApplicationRecord
require 'carrierwave/orm/activerecord'
mount_uploader :photo, AvatarUploader
belongs_to :sender, class_name: 'User'
belongs_to :recipient, class_name: 'User'
validates :read_count_allowed, :numericality => { :greater_than => 0}
validates :subject, presence: true
validates :body, presence: true
	def message
		Message.where(message_id: id)
	end
end
