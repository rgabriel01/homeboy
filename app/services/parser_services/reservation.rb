module ParserServices
  class Reservation
    def initialize(payload)
      @payload = payload
    end

    def self.parse(payload)
      new(payload).parse
    end

    def parse
      {
        code: parse_code,
        start_date: parse_start_date,
        end_date: parse_end_date,
        nights: parse_nights,
        adult_guest_count: parse_adult_guest_count,
        children_guest_count: parse_children_guest_count,
        infant_guest_count: parse_infant_guest_count,
        security_price: parse_security_price,
        payout_price: parse_payout_price,
        total_price: parse_total_price,
        currency: parse_currency,
        status: parse_status
      }
    end

    private

    def parse_code
      return @payload[:reservation_code] if @payload.key?('reservation_code')
      return @payload[:reservation][:code] if @payload.key?('reservation') && @payload[:reservation].key?('code')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'code')
    end

    def parse_start_date
      return @payload[:start_date] if @payload.key?('start_date')
      return @payload[:reservation][:start_date] if @payload.key?('reservation') && @payload[:reservation].key?('start_date')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'start_date')
    end

    def parse_end_date
      return @payload[:end_date] if @payload.key?('end_date')
      return @payload[:reservation][:end_date] if @payload.key?('reservation') && @payload[:reservation].key?('end_date')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'end_date')
    end

    def parse_nights
      return @payload[:nights] if @payload.key?('nights')
      return @payload[:reservation][:nights] if @payload.key?('reservation') && @payload[:reservation].key?('nights')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'nights')
    end

    def parse_adult_guest_count
      return @payload[:adults] if @payload.key?('adults')
      return @payload[:reservation][:guest_details][:number_of_adults] if @payload.key?('reservation') && @payload[:reservation].key?('guest_details') && @payload[:reservation][:guest_details].key?('number_of_adults')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'adult_guests_count')
    end

    def parse_children_guest_count
      return @payload[:children] if @payload.key?('children')
      return @payload[:reservation][:guest_details][:number_of_children] if @payload.key?('reservation') && @payload[:reservation].key?('guest_details') && @payload[:reservation][:guest_details].key?('number_of_children')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'children_guest_count')
    end

    def parse_infant_guest_count
      return @payload[:infants] if @payload.key?('infants')
      return @payload[:reservation][:guest_details][:number_of_infants] if @payload.key?('reservation') && @payload[:reservation].key?('guest_details') && @payload[:reservation][:guest_details].key?('number_of_infants')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'infant_guests_count')
    end

    def parse_security_price
      return @payload[:security_price] if @payload.key?('security_price')
      return @payload[:reservation][:listing_security_price_accurate] if @payload.key?('reservation') && @payload[:reservation].key?('listing_security_price_accurate')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'security_price')
    end

    def parse_payout_price
      return @payload[:payout_price] if @payload.key?('payout_price')
      return @payload[:reservation][:expected_payout_amount] if @payload.key?('reservation') && @payload[:reservation].key?('expected_payout_amount')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'payout_price')
    end

    def parse_total_price
      return @payload[:total_price] if @payload.key?('total_price')
      return @payload[:reservation][:total_paid_amount_accurate] if @payload.key?('reservation') && @payload[:reservation].key?('total_paid_amount_accurate')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'total_price')
    end

    def parse_currency
      return @payload[:currency] if @payload.key?('currency')
      return @payload[:reservation][:host_currency] if @payload.key?('reservation') && @payload[:reservation].key?('host_currency')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'host_currency')
    end

    def parse_status
      return @payload[:status] if @payload.key?('status')
      return @payload[:reservation][:status_type] if @payload.key?('reservation') && @payload[:reservation].key?('status_type')
      raise Exceptions::InvalidFormatError.new('Invalid reservation payload format', 'status')
    end
  end
end
