require_relative '../transports/car'
require_relative '../transports/bike'
require 'securerandom'

class DeliveryService
  include Constants::Bike

  attr_reader :park, :cars, :bikes

  def initialize(
    cars_count, bikes_count, cars_availability, bikes_availability,
    cars = cars_count.times.map { Car.new(cars_availability, SecureRandom.uuid, rand(10), rand(100), %w[on_route in_garage].sample) },
    bikes = bikes_count.times.map { Bike.new(bikes_availability, rand(10), rand(100), %w[on_route in_garage].sample) }
  )
    @cars = cars
    @bikes = bikes
    @park = @cars + @bikes
  end

  def get_transport(weight, distance)
    raise(StandardError, "Sorry we don't have available transport now") if available_transport.empty?

    weight <= BIKE_MAX_WEIGHT && distance <= BIKE_MAX_DISTANCE ? available_bikes : available_cars
  end

  private

  def available_transport
    @park.select do |t|
      t.available == true
    end
  end

  def search_transport(klass)
    available_transport.select do |t|
      t.instance_of?(klass)
    end
  end

  def available_bikes
    bikes = search_transport(Bike)
    bikes.empty? ? search_transport(Car) : bikes
  end

  def available_cars
    cars = search_transport(Car)
    cars.empty? ? raise(StandardError, "Sorry we don't have available cars now") : cars
  end
end
