# frozen_string_literal: true

require_relative 'transport'
require_relative '../utils/constants'

class Bike < Transport
  include Constants::Bike

  attr_reader :max_distance

  @instances = []

  def initialize(available, number_of_deliveries, delivery_cost, location)
    super(BIKE_MAX_WEIGHT, BIKE_SPEED, available, number_of_deliveries, delivery_cost, location)
    @max_distance = BIKE_MAX_DISTANCE
    self.class.instance_variable_get(:@instances) << self
  end

  # class << self
  #   def all
  #     instance_variable_get(:@instances)
  #   end
  # end
end
