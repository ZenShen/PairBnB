class ReservationsController < ApplicationController
	def create
		# byebug
		listing = Listing.find(params[:listing_id])
		reservation = listing.reservations.new(reservation_params)
		reservation.calculate_price 

		@customer = reservation.user 
		@host = listing.user
		@reservation_id = reservation.id
		@property_name = reservation.listing.property_name

		if reservation.save
			redirect_to listing, notice: "Reservation successfu! Your host will contact you."
			ReservationJob.perform_later(@customer, @host, @reservation_id, @property_name)
			# ReservationMailer.booking_email(@customer, @host, @reservation_id, @property_name).deliver_now
		else
			redirect_to @listing, notice: "Reservation failed"
		end
	end

	def show
		reservation = Reservation.find(params[:id])
		@reservation = reservation
		@reservation_id = reservation.id
		@customer = reservation.user.email
		@check_in = reservation.check_in
		@check_out = reservation.check_out
		@total = reservation.total_price
		@name = reservation.listing.property_name
	end

	private

	def reservation_params
		params.require(:reservation).permit(:check_in, :check_out, :user_id, :listing_id)
	end
end
