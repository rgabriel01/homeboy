module ProfileServices
  class Reservation
    def initialize(guest_id, payload)
      @payload = payload
      @guest_id = guest_id
    end

    def self.create!(guest_id, payload)
      new(guest_id, payload).create!
    end

    def create!
      reservation = ::Reservation
        .where(code: @payload[:code])
        .first_or_create!(reservation_attributes)
    end

    private

    def reservation_attributes
      @reservation_attributes ||= begin
        reservation_payload = @payload.clone
        reservation_payload[:guest_id] = @guest_id
        reservation_payload
      end
    end
  end
end
