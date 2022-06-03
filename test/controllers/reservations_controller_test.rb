require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  def test_should_create_reservation_payload_1
    payload = {
      "reservation_code" => "AAA12345678",
      "start_date" => "2021-04-14",
      "end_date" => "2021-04-18",
      "nights" => 4,
      "guests" => 4,
      "adults" => 2,
      "children" => 2,
      "infants" => 0,
      "status" => "accepted",
      "guest" => {
        "first_name" => "Wayne",
        "last_name" => "Woodbridge",
        "phone" => "639123456789",
        "email" => "kamille@bnb.com"
      },
      "currency" => "AUD",
      "payout_price" => "4200.00",
      "security_price" => "500",
      "total_price" => "4700.00"
    }

    post reservations_path, params: payload

    assert_response :success
    assert 1, Guest.count
    assert 1, Reservation.count
    assert 1, Guest.where(email: payload['guest']['email']).count
    assert 1, Reservation.where(code: payload['reservation_code']).count

    response_body = response.parsed_body['data']
    assert response_body.key?('guest')
    assert response_body.key?('reservation')
  end

  def test_should_create_reservation_payload_2
    payload = {
      "reservation" => {
        "code" => "TYU12345678",
        "start_date" => "2021-03-12",
        "end_date" => "2021-03-16",
        "expected_payout_amount" => "3800.00",
        "guest_details" => {
          "localized_description" => "4 guests",
          "number_of_adults" => 2,
          "number_of_children" => 2,
          "number_of_infants" => 0
        },
        "guest_email" => "dd@bnb.com",
        "guest_first_name" => "Wayne",
        "guest_last_name" => "Woodbridge",
        "guest_phone_numbers" => [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate" => "500.00",
        "host_currency" => "AUD",
        "nights" => 4,
        "number_of_guests" => 4,
        "status_type" => "accepted",
        "total_paid_amount_accurate" => "4300.00"
      }
    }

    post reservations_path, params: payload

    assert_response :success
    assert 1, Guest.count
    assert 1, Reservation.count
    assert 1, Guest.where(email: payload['reservation']['guest_email']).count
    assert 1, Reservation.where(code: payload['reservation']['code']).count

    response_body = response.parsed_body['data']
    assert response_body.key?('guest')
    assert response_body.key?('reservation')
  end

  def test_should_catch_format_fail_exceptions
    payload = {
      "reservation" => {
        "codeXXXXX" => "TYU12345678",
        "start_date" => "2021-03-12",
        "end_date" => "2021-03-16",
        "expected_payout_amount" => "3800.00",
        "guest_details" => {
          "localized_description" => "4 guests",
          "number_of_adults" => 2,
          "number_of_children" => 2,
          "number_of_infants" => 0
        },
        "guest_email" => "dd@bnb.com",
        "guest_first_name" => "Wayne",
        "guest_last_name" => "Woodbridge",
        "guest_phone_numbers" => [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate" => "500.00",
        "host_currency" => "AUD",
        "nights" => 4,
        "number_of_guests" => 4,
        "status_type" => "accepted",
        "total_paid_amount_accurate" => "4300.00"
      }
    }

    post reservations_path, params: payload
    assert_equal 422, response.status
    response_body = response.parsed_body['data']
    assert response_body.key?('error')
    assert_equal 0, Reservation.count
  end
end
