class ReservationsController < ActionController::API
  def create
    guest = GuestParserService.parse(params)
    render json: {success: true, data: { guest: guest } }
  end
end
