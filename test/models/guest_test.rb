require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test 'valid structure' do
    guest = Guest.new(email: 'mon@mon.com', first_name: 'Raymond', last_name: 'Gabriel')
    assert guest.valid?
  end

  test 'validates for email format and presence' do
    guest = Guest.new(first_name: 'Danny', last_name: 'Ricciardo')
    refute guest.valid?
    assert guest.errors.full_messages.include?("Email can't be blank")
    assert guest.errors.full_messages.include?('Email is not of valid format.')
  end

  test 'validate for first_name' do
    guest = Guest.new(email: 'maxverstappen@redbull.com', last_name: 'Verstappen')
    refute guest.valid?
    assert guest.errors.full_messages.include?("First name can't be blank")
  end

  test 'validate for last_name' do
    guest = Guest.new(email: 'maxverstappen@redbull.com', first_name: 'Max')
    refute guest.valid?
    assert guest.errors.full_messages.include?("Last name can't be blank")
  end
end
