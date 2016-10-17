class User < ApplicationRecord
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	has_secure_password 
	def incoming_messages
		Message.where(recipient_id: id).order(created_at: :desc)
	end

	def to_s
		email
	end
end
