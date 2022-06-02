class ReservationsController < ActionController::API
  def create
    guest = ParserServices::Guest.parse(params)
    gg = ProfileServices::Guest.create!(guest)
    render json: {success: true, data: { guest: gg } }
  end
end
