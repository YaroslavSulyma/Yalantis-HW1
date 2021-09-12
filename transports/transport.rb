# frozen_string_literal: true

require_relative '../utils/constants'

class Transport
  include Comparable

  attr_accessor :max_weight, :speed, :available, :number_of_deliveries, :delivery_cost, :location

  def initialize(max_weight, speed, available, number_of_deliveries, delivery_cost, location)
    @max_weight = max_weight
    @speed = speed
    @available = available
    @number_of_deliveries = number_of_deliveries
    @delivery_cost = delivery_cost
    %w[on_route in_garage].include?(location) ? @location = location : raise(ArgumentError, 'Location should be on_route or in_garage')
  end

  def self.all
    Car.all + Bike.all
  end

  class << self
    %i[max_weight speed available number_of_deliveries delivery_cost].each do |attribute|
      define_method :"find_by_#{attribute}" do |value|
        all.find { |transport| transport.public_send(attribute) == value }
      end
    end
  end

  class << self
    %i[max_weight speed available number_of_deliveries delivery_cost].each do |attribute|
      define_method :"filter_by_#{attribute}" do |value = nil, &block|
        block ? (all.select { |transport| block.call transport.public_send(attribute) }) : (all.select { |transport| transport.public_send(attribute) == value })
      end
    end
  end

  def delivery_time(distance)
    Float(distance) / @speed
  end

  def <=>(other)
    (max_weight <=> other.max_weight).zero? ? max_distance <=> Float::INFINITY : max_weight <=> other.max_weight
  end
end
