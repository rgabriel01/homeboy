class ReservationsController < ActionController::API
  def create
    parsed_guest = ParserServices::Guest.parse(params)
    guest = ProfileServices::Guest.create!(parsed_guest)
    parsed_reservation = ParserServices::Reservation.parse(params)
    reservation = ProfileServices::Reservation.create!(guest.id, parsed_reservation)

    render json: {success: true, data: { guest: guest, reservation: reservation } }
  end
end
