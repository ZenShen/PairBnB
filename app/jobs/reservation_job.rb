class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(customer,host,reservation_id,property_name)
    # Do something later
    ReservationMailer.booking_email(customer,host,reservation_id,property_name).deliver_now
  end
end
 