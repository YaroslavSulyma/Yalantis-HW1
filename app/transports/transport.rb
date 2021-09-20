# frozen_string_literal: true

class Transport
  include Comparable

  attr_accessor :max_weight, :speed, :available, :number_of_deliveries, :delivery_cost, :location

  @instances = []

  def initialize(max_weight, speed, available, number_of_deliveries, delivery_cost, location)
    @max_weight = max_weight
    @speed = speed
    @available = available
    @number_of_deliveries = number_of_deliveries
    @delivery_cost = delivery_cost
    %w[on_route in_garage].include?(location) ? @location = location : raise(ArgumentError, 'Location should be on_route or in_garage')
    self.class.instance_variable_get(:@instances) << self
  end

  class << self

    def all
      instance_variable_get(:@instances)
    end

    %i[max_weight speed available number_of_deliveries delivery_cost location].each do |attribute|
      define_method :"find_by_#{attribute}" do |value|
        all.find { |transport| transport.public_send(attribute) == value }
      end
      define_method :"filter_by_#{attribute}" do |value = nil, &block|
        block ? (all.select { |transport| block.call transport.public_send(attribute) }) : (all.select { |transport| transport.public_send(attribute) == value })
      end
    end
  end

  def delivery_time(distance)
    Float(distance) / @speed
  end

  def <=>(other)
    if (max_weight <=> other.max_weight).zero?
      self.is_a?(Car) ? max_distance <=> Float::INFINITY : raise(StandardError, "This type of transport don't have distance limit")
    else
      max_weight <=> other.max_weight
    end
  end
end
