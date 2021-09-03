require_relative 'transport'

class Bike < Transport
  include Constants::Bike

  attr_reader :max_distance

  def initialize(available)
    super(BIKE_MAX_WEIGHT, BIKE_SPEED, available)
    @max_distance = BIKE_MAX_DISTANCE
  end
end
