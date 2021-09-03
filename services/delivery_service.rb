require_relative '../transports/car'
require_relative '../transports/bike'
require 'securerandom'

class DeliveryService
  include Constants::Bike

  attr_reader :park, :cars, :bikes

  def initialize(
    cars = 7.times.collect { Car.new([true, false].sample, SecureRandom.uuid) },
    bikes = 7.times.collect { Bike.new([true, false].sample) }
  )
    @cars = cars
    @bikes = bikes
    @park = @cars + @bikes
  end

  def get_transport(weight, distance)

    available_delivery_transport = available_transport(@park)

    if available_delivery_transport.empty?
      raise(StandardError, "Sorry we don't have available transport now")
    elsif weight <= BIKE_MAX_WEIGHT && distance <= BIKE_MAX_DISTANCE
      get_available_bikes(available_delivery_transport)
    else
      get_available_cars(available_delivery_transport)
    end
  end

  private

  def available_transport(transport)
    transport.select do |t|
      t.available == true
    end
  end

  def get_bikes(park)
    park.select do |t|
      t.instance_of?(Bike)
    end
  end

  def get_available_bikes(available_delivery_transport)
    bikes = get_bikes(available_delivery_transport)
    bikes.empty? ? get_cars(available_delivery_transport) : bikes
  end

  def get_available_cars(available_delivery_transport)
    cars = get_cars(available_delivery_transport)
    cars.empty? ? raise(StandardError, "Sorry we don't have available cars now") : cars
  end

  def get_cars(park)
    park.select do |t|
      t.instance_of?(Car)
    end
  end
end

#
# service = DeliveryService.new
# print service.get_transport(10, 31)

t1 = Bike.new(true)
t2 = Bike.new(true)

print t1 > t2