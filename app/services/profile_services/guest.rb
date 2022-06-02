module ProfileServices
  class Guest
    def initialize(payload)
      @payload = payload
    end

    def self.create!(payload)
      new(payload).create!
    end

    def create!
      guest = ::Guest
        .where(email: guest_attributes[:email])
        .first_or_create!(guest_attributes)
      guest
    end

    private

    def guest_attributes
      @guest_attributes ||= begin
        guest_payload = @payload.clone.except(:phone_numbers)
        phone_numbers = @payload[:phone_numbers].map do |phone_number|
          { number: phone_number }
        end
        guest_payload[:phone_numbers_attributes] = phone_numbers
        guest_payload
      end
    end
  end
end
