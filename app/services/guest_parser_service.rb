class GuestParserService
  def initialize(payload)
    @payload = payload
  end

  def self.parse(payload)
    new(payload).parse
  end

  def parse
    {
      first_name: parse_email,
      last_name: parse_first_name,
      email: parse_last_name,
      phone: parse_phone_numbers
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
