class ReservationsController < ActionController::API
  def create
    render json: {success: true, data: { hello: 'hello' } }
  end
end
