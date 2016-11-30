class Reservation < ActiveRecord::Base
	belongs_to :listing
	belongs_to :user

	def calculate_price
		price_per_night = self.listing.price.to_i
		duration = (self.check_out - self.check_in).to_i
		self.total_price = price_per_night * duration
		self.save
	end
end
