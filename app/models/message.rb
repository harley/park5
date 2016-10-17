class Message < ApplicationRecord
belongs_to :sender, class_name: 'User'
belongs_to :recipient, class_name: 'User'
	def message
		Message.where(message_id: id)
	end
end
