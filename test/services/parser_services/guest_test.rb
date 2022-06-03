require 'test_helper'

class ParserServices::GuestTest < ActiveSupport::TestCase
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

    parsed_guest = ParserServices::Guest.parse(payload)
    assert_equal parsed_guest[:email], payload["guest"]["email"]
    assert_equal parsed_guest[:first_name], payload["guest"]["first_name"]
    assert_equal parsed_guest[:last_name], payload["guest"]["last_name"]

    assert_equal parsed_guest[:phone_numbers], [payload["guest"]["phone"]]
    assert_equal parsed_guest[:phone_numbers].length, 1
    assert parsed_guest[:phone_numbers].include?(payload["guest"]["phone"])
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

    parsed_guest = ParserServices::Guest.parse(payload)
    assert_equal parsed_guest[:email], payload["reservation"]["guest_email"]
    assert_equal parsed_guest[:first_name], payload["reservation"]["guest_first_name"]
    assert_equal parsed_guest[:last_name], payload["reservation"]["guest_last_name"]

    assert_equal parsed_guest[:phone_numbers], payload["reservation"]["guest_phone_numbers"]
    assert_equal parsed_guest[:phone_numbers].length, 2

    parsed_guest[:phone_numbers].each do |phone|
      assert payload["reservation"]["guest_phone_numbers"].include?(phone)
    end
  end

  test 'raises an InvalidFormatError type exception on unknown formats' do
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
        "guestx_email" => "dd@bnb.com",
        "guestx_first_name" => "Wayne",
        "guestx_last_name" => "Woodbridge",
        "guestx_phone_numbers" => [
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

    assert_raises Exceptions::InvalidFormatError do
      ParserServices::Guest.parse(payload)
    end
  end
end
