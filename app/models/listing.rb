class Listing < ActiveRecord::Base
	belongs_to :user

	def mine?(user)
		if user.nil?
			return false
		else
			return self.user_id == user.id
		end
	end
end