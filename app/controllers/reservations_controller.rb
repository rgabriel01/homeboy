class ReservationsController < ActionController::API
  def create
    guest = ParserServices::Guest.parse(params)
    gg = ProfileServices::Guest.create!(guest)
    reservation = ParserServices::Reservation.parse(params)
    render json: {success: true, data: { guest: gg, reservation: reservation } }
  end
end
