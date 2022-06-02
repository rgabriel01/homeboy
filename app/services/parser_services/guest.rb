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
      return @payload[:guest][:email] if @payload.key?('guest')
      return @payload[:reservation][:guest_email] if @payload.key?('reservation')
      ''
    end

    def parse_first_name
      return @payload[:guest][:first_name] if @payload.key?('guest')
      return @payload[:reservation][:guest_first_name] if @payload.key?('reservation')
      ''
    end

    def parse_last_name
      return @payload[:guest][:last_name] if @payload.key?('guest')
      return @payload[:reservation][:guest_last_name] if @payload.key?('reservation')
      ''
    end


    def parse_phone_numbers
      return [@payload[:guest][:phone]] if @payload.key?('guest')
      return @payload[:reservation][:guest_phone_numbers] if @payload.key?('reservation')
      []
    end
  end
end
