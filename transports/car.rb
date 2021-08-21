require './transports/transport'

class Car < Transport
  include Constants

  attr_accessor :registration_number

  def initialize(available, registration_number)
    super(max_weight = CAR_MAX_WEIGHT, speed = CAR_SPEED, available)
    @registration_number = registration_number
  end
end
