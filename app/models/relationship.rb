class Relationship < ApplicationRecord
	belongs_to :first_person, class_name: 'User'
	belongs_to :second_person, class_name: 'User'
	validates :first_person_id, uniqueness: { scope: [:first_person_id, :second_person_id] }
	def self.list_friend(id)
		#Relationship.where(first_person_id: id)
		Relationship.where("first_person_id = ? OR second_person_id = ? ", id, id)
	end
	def to_s
		email
	end
end
