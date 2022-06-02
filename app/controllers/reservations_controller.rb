class ReservationsController < ActionController::API
  def create
    guest = GuestParserService.parse(params)
    gg = GuestManagerService.create!(guest)
    render json: {success: true, data: { guest: guest } }
  end
end
