class ReservationsController < ActionController::API
  rescue_from Exceptions::InvalidFormatError, :with => :handle_invalid_format

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

  private

  def handle_invalid_format(exception)
    render json: {
      success: false,
      data: {
        error: "#{exception.message}: #{exception.field}"
      }
    }, status: 422
  end
end
