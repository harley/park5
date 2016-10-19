class Relationship < ApplicationRecord
	belongs_to :first_person, class_name: 'User'
	belongs_to :second_person, class_name: 'User'
	validates :first_person_id, uniqueness: { scope: [:first_person_id, :second_person_id] }
	
	def self.check_relation_exist(first_id, second_id)
		@Relation = Relationship.where("first_person_id = ? AND second_person_id = ? ", first_id,second_id).first
		if @Relation
			return @Relation
		else
			@Relation = Relationship.where("first_person_id = ? AND second_person_id = ? ", second_id,first_id).first
			if @Relation
				return @Relation
			end
		end
		nil
	end

	def to_s
		email
	end
end
