require './transports/bike'
require './transports/car'
require 'securerandom'

class DeliveryService
  include Constants

  attr_reader :park, :cars, :bikes

  def initialize
    @cars = rand(7).times.collect { Car.new([true, false].sample, SecureRandom.uuid) }
    @bikes = rand(7).times.collect { Bike.new([true, false].sample) }
    @park = @cars + @bikes
  end

  def get_transport(weight, distance)

    available_delivery_transport = available_transport(@park)

    if available_delivery_transport.empty?
      Exception.new("Sorry we don't have available transport now")
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
    cars.empty? ? Exception.new("Sorry we don't have available cars now") : cars
  end

  def get_cars(park)
    park.select do |t|
      t.instance_of?(Car)
    end
  end
end

service = DeliveryService.new
print service.get_transport(10, 31)
