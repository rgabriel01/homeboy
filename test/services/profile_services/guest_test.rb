require 'test_helper'

class ProfileServices::GuestTest < ActiveSupport::TestCase
  test 'creation of guest for payload 1' do
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

    assert 0, Guest.count
    ProfileServices::Guest.create!(payload)
    assert 1, Guest.count
  end

  test 'creation of guest for payload 2' do
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

    assert 0, Guest.count
    ProfileServices::Guest.create!(payload)
    assert 1, Guest.count
  end
end
