require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  test 'test for valid structure' do
    guest = Guest.create(email: 'mon@mon.com', first_name: 'Raymond', last_name: 'Gabriel')
    reservation = Reservation.new(
      code: 'XXX',
      guest_id: guest.id,
      start_date: '2021-03-12',
      end_date: '2021-03-20',
      nights: 4,
      adult_guest_count: 2,
      children_guest_count: 1,
      infant_guest_count: 0,
      security_price: '500.00',
      payout_price: '4200.00',
      total_price: '4700.00',
      currency: 'AUD',
      status: 'accepted'
    )
    assert reservation.valid?
  end

  test 'validate for code uniqueness' do
    guest = Guest.create(email: 'mon@mon.com', first_name: 'Raymond', last_name: 'Gabriel')
    reservation = Reservation.create(
      code: 'XXX',
      guest_id: guest.id,
      start_date: '2021-03-12',
      end_date: '2021-03-20',
      nights: 4,
      adult_guest_count: 2,
      children_guest_count: 1,
      infant_guest_count: 0,
      security_price: '500.00',
      payout_price: '4200.00',
      total_price: '4700.00',
      currency: 'AUD',
      status: 'accepted'
    )

    new_reservation = Reservation.new(
      code: 'XXX',
      guest_id: guest.id,
      start_date: '2021-03-12',
      end_date: '2021-03-20',
      nights: 4,
      adult_guest_count: 2,
      children_guest_count: 1,
      infant_guest_count: 0,
      security_price: '500.00',
      payout_price: '4200.00',
      total_price: '4700.00',
      currency: 'AUD',
      status: 'accepted'
    )
    refute new_reservation.valid?
    assert new_reservation.errors.full_messages.include?('Code has already been taken')
  end

  test 'validate for code guest_id presence' do
    reservation = Reservation.create(
      code: 'XXX',
      start_date: '2021-03-12',
      end_date: '2021-03-20',
      nights: 4,
      adult_guest_count: 2,
      children_guest_count: 1,
      infant_guest_count: 0,
      security_price: '500.00',
      payout_price: '4200.00',
      total_price: '4700.00',
      currency: 'AUD',
      status: 'accepted'
    )

    refute reservation.valid?
    assert reservation.errors.full_messages.include?('Guest must exist')
    assert reservation.errors.full_messages.include?("Guest can't be blank")
  end
end
