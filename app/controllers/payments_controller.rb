class PaymentsController < ApplicationController

  def new

  	gon.client_token = generate_client_token
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @listing = @reservation.listing
    @result = Braintree::Transaction.sale(
              amount: @reservation.total_price,
              payment_method_nonce: params[:payment_method_nonce])
    @customer = @reservation.user 
    @host = @listing.user
    @reservation_id = @reservation.id
    @property_name = @reservation.listing.property_name

    if @result.success?
      @reservation.save
      ReservationJob.perform_later(@customer, @host, @reservation_id, @property_name)
      redirect_to listing_reservation_path(@listing.id,@reservation.id), notice: "Congraulations! Your transaction has been successfully!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private

  def generate_client_token
  	Braintree::ClientToken.generate 
  end 
end
