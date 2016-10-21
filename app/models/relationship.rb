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

	def self.list_all_friend(id)
		# @friend_list = []
		# @Relationships.each do |relationship|
		# 	@friend_list.
		# end
		# User.where(:id => @friend_list)

		# @list_friend = Relationship.select("second_person_id as friend_id, id").where(first_person_id: id, relation: nil) 
		# + Relationship.select("first_person_id as friend_id, id").where(second_person_id: id, relation: nil)
		@list_friend = 			Relationship.find_by_sql ["Select * from RELATIONSHIPS where 
			second_person_id = ? AND first_person_id not in (
			Select friend_id from blocked_friends where user_id = ?) OR 
			(first_person_id = ? AND second_person_id not in (
			Select friend_id from blocked_friends where user_id = ?))", id, id, id, id] 

	end
end
