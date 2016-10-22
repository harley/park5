class User < ApplicationRecord
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	has_secure_password

	def incoming_messages
		
		Message.find_by_sql ["Select * from MESSAGES where
			recipient_id = ? AND sender_id NOT IN (SELECT friend_id FROM blocked_friends WHERE user_id = ?) order by created_at desc", id, id] 
	end

	def outgoing_messages
		Message.where(sender_id: id)
	end
	
	def self.list_all_user(id)
		User.where.not(id: id)
	end

	def self.list_friend(id)
		@AllRelation = Relationship.where(first_person_id: id).pluck(:second_person_id) + Relationship.where(second_person_id: id).pluck(:first_person_id)
		User.where(:id => @AllRelation) 
	end

	def to_s
		email
	end

 	def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
		if email
			user = where(email: email).first
			unless user
				user.email = email
				user.password_digest = random_password
				user.save!
			end
		end
    #
    # Set other properties on user here.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally, return user
    user
  end
	
	def self.random_password
		('a'..'z').to_a.shuffle[0,8].join
		#for more secure random, use securerandom
	end
end
