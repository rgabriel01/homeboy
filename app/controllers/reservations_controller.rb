class ReservationsController < ActionController::API
  def create
    guest = ProfileServices::Guest.create!(params)
    reservation = ProfileServices::Reservation.create!(guest.id, params)

    render json: {
      success: true,
      data: {
        guest: guest,
        reservation: reservation
      }
    }
  end
end
