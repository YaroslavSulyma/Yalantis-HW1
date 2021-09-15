require_relative 'transport'

class Car < Transport
  include Constants::Car

  attr_accessor :registration_number

  @instances = []

  def initialize(available, registration_number, number_of_deliveries, delivery_cost, location)
    super(CAR_MAX_WEIGHT, CAR_SPEED, available, number_of_deliveries, delivery_cost, location)
    @registration_number = registration_number
    self.class.instance_variable_get(:@instances) << self
  end
end
