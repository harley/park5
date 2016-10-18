class User < ApplicationRecord
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	has_secure_password

	def incoming_messages
		Message.where(recipient_id: id).order(created_at: :desc)
	end

	def outgoing_messages
		Message.where(sender_id: id)
	end
	
	def self.list_all_user(id)
		User.where.not(id: id)
	end

	def self.list_friend(id)
		#Friend_id = Relationship.where(first_person_id: id)
		#User.where("id in (?)",Friend_id)
		#ERROR dynamic constant assignment Friend_id = Relationship.where(first_person_id: id)

		User.where(id: Relationship.where(first_person_id: 2).pluck(:second_person_id))

		#SELECT email,id from Users where id in (select second_person_id from Relationships where first_person_id =) 
	end

	def to_s
		email
	end
end
