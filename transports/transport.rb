require_relative '../utils/constants'

class Transport
  include Comparable

  attr_accessor :max_weight, :speed, :available

  def initialize(max_weight, speed, available)
    @max_weight = max_weight
    @speed = speed
    @available = available
  end

  def delivery_time(distance)
    Float(distance) / @speed
  end

  def <=>(other)
    if (max_weight <=> other.max_weight).zero?
      max_distance <=> Float::INFINITY
    else
      max_weight <=> other.max_weight
    end
  end
end
