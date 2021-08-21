require './transports/transport'

class Bike < Transport
  include Constants

  attr_reader :max_distance

  def initialize(available)
    super(max_weight = BIKE_MAX_WEIGHT, speed = BIKE_SPEED, available)
    @max_distance = BIKE_MAX_DISTANCE
  end
end
