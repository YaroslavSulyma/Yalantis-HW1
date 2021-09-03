require_relative 'transport'

class Car < Transport
  include Constants::Car

  attr_accessor :registration_number

  def initialize(available, registration_number)
    super(CAR_MAX_WEIGHT, CAR_SPEED, available)
    @registration_number = registration_number
  end
end
