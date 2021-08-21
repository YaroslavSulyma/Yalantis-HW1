require './utils/constants'

class Transport
  include Comparable

  attr_accessor :max_weight, :speed, :available

  def initialize(max_weight, speed, available)
    @max_weight = max_weightgi
    @speed = speed
    @available = available
  end

  def delivery_time(distance)
    Float(distance) / @speed
  end

  def <=>(other)
    delivery_time(distance) <=> other.delivery_time
  end
end
