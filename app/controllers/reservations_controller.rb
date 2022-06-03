class ReservationsController < ActionController::API
  rescue_from Exceptions::InvalidFormatError, :with => :handle_invalid_format

  def create
    guest = ProfileServices::Guest.create!(params)
    reservation = ProfileServices::Reservation.create!(guest.id,params)

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

  def permitted_params
    params
      .permit(
        :reservation_code,
        :start_date,
        :end_date,
        :nights,
        :guests,
        :adults,
        :children,
        :infants,
        :status,
        {:guest => [:first_name, :last_name, :email, :phone]},
        :currency,
        :payout_price,
        :security_price,
        :total_price,
        {:reservation => [
          :code,
          :start_date,
          :end_date,
          :expected_payout_amount,
          {:guest_details => [:number_of_adults, :number_of_children, :number_of_infants]},
          :guest_email,
          :guest_first_name,
          :guest_last_name,
          {:guest_phone_numbers => []},
          :listing_security_price_accurate,
          :host_currency,
          :nights,
          :number_of_guests,
          :status_type,
          :total_paid_amount_accurate,
        ]}
      )
  end
end
