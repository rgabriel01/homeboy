module ParserServices
  class Guest
    def initialize(payload)
      @payload = payload
    end

    def self.parse(payload)
      new(payload).parse
    end

    def parse
      {
        email: parse_email,
        first_name: parse_first_name,
        last_name: parse_last_name,
        phone_numbers: parse_phone_numbers
      }
    end

    private

    def parse_email
      return @payload['guest']['email'] if @payload.key?('guest') && @payload['guest'].key?('email')
      return @payload['reservation']['guest_email'] if @payload.key?('reservation') && @payload['reservation'].key?('guest_email')
      raise Exceptions::InvalidFormatError.new('Invalid guest payload format', 'email')
    end

    def parse_first_name
      return @payload['guest']['first_name'] if @payload.key?('guest') && @payload['guest'].key?('first_name')
      return @payload['reservation']['guest_first_name'] if @payload.key?('reservation') && @payload['reservation'].key?('guest_first_name')
      raise Exceptions::InvalidFormatError.new('Invalid guest payload format', 'first_name')
    end

    def parse_last_name
      return @payload['guest']['last_name'] if @payload.key?('guest') && @payload['guest'].key?('last_name')
      return @payload['reservation']['guest_last_name'] if @payload.key?('reservation') && @payload['reservation'].key?('guest_last_name')
      raise Exceptions::InvalidFormatError.new('Invalid guest payload format', 'last_name')
    end

    def parse_phone_numbers
      return [@payload['guest']['phone']] if @payload.key?('guest') && @payload['guest'].key?('phone')
      return @payload['reservation']['guest_phone_numbers'] if @payload.key?('reservation') && @payload['reservation'].key?('guest_phone_numbers')
      raise Exceptions::InvalidFormatError.new('Invalid guest payload format', 'phone_number')
    end
  end
end
