class ReservationMailer < ApplicationMailer

# default from: "noreply@example.com"

	def booking_email(customer, host, reservation_id, property_name)
		# byebug
		@property_name = property_name
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		@reservation = Reservation.find(reservation_id)
		@url = "http://localhost:3000/listings/#{@reservation.listing.id}/reservations/#{@reservation.id}"
		mail(to: @host.email, 
			 subject: "You've received a reservation from one of your listings!")
	end
end
