module Exceptions
  class InvalidFormatError < StandardError
    attr_reader :field
    def initialize(msg='Unknown payload format', field)
      @field = field
      super(msg)
    end
  end
end
