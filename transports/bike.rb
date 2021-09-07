require_relative 'transport'

class Bike < Transport
  include Constants::Bike

  attr_reader :max_distance

  def initialize(available, number_of_deliveries, delivery_cost, location)
    super(BIKE_MAX_WEIGHT, BIKE_SPEED, available, number_of_deliveries, delivery_cost, location)
    @max_distance = BIKE_MAX_DISTANCE
  end
end
