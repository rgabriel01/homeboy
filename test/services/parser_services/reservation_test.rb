require 'test_helper'

class ParserServices::ReservationTest < ActiveSupport::TestCase
  test 'valid structure for payload 1' do
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

    parsed_reservation = ParserServices::Reservation.parse(payload)

    assert_equal parsed_reservation[:code], payload["reservation_code"]
    assert_equal parsed_reservation[:start_date], payload["start_date"]
    assert_equal parsed_reservation[:end_date], payload["end_date"]
    assert_equal parsed_reservation[:nights], payload["nights"]

    assert_equal parsed_reservation[:adult_guest_count], payload["adults"]
    assert_equal parsed_reservation[:children_guest_count], payload["children"]
    assert_equal parsed_reservation[:infant_guest_count], payload["infants"]

    assert_equal parsed_reservation[:security_price], payload["security_price"]
    assert_equal parsed_reservation[:payout_price], payload["payout_price"]
    assert_equal parsed_reservation[:total_price], payload["total_price"]

    assert_equal parsed_reservation[:currency], payload["currency"]
    assert_equal parsed_reservation[:status], payload["status"]

  end

  test 'valid structure for payload 2' do
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

    parsed_reservation = ParserServices::Reservation.parse(payload)

    assert_equal parsed_reservation[:code], payload["reservation"]["code"]
    assert_equal parsed_reservation[:start_date], payload["reservation"]["start_date"]
    assert_equal parsed_reservation[:end_date], payload["reservation"]["end_date"]
    assert_equal parsed_reservation[:nights], payload["reservation"]["nights"]

    assert_equal parsed_reservation[:adult_guest_count], payload["reservation"]["guest_details"]["number_of_adults"]
    assert_equal parsed_reservation[:children_guest_count], payload["reservation"]["guest_details"]["number_of_children"]
    assert_equal parsed_reservation[:infant_guest_count], payload["reservation"]["guest_details"]["number_of_infants"]

    assert_equal parsed_reservation[:security_price], payload["reservation"]["listing_security_price_accurate"]
    assert_equal parsed_reservation[:payout_price], payload["reservation"]["expected_payout_amount"]
    assert_equal parsed_reservation[:total_price], payload["reservation"]["total_paid_amount_accurate"]

    assert_equal parsed_reservation[:currency], payload["reservation"]["host_currency"]
    assert_equal parsed_reservation[:status], payload["reservation"]["status_type"]
  end
end
