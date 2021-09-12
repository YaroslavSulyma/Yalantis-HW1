require 'rspec'
require_relative '../services/delivery_service'

describe DeliveryService do
  cars_count = 6
  bikes_count = 6
  bikes_availability = true
  cars_availability = true
  weight = 10
  distance = 30

  let(:available_transport) { described_class.new(cars_count, bikes_count, cars_availability, bikes_availability) }
  let(:unavailable_transport) { described_class.new(cars_count, bikes_count, cars_availability = false, bikes_availability = false) }
  let(:unavailable_cars) { described_class.new(cars_count, bikes_count, cars_availability = false, bikes_availability = true) }
  let(:unavailable_bikes) { described_class.new(cars_count, bikes_count, cars_availability = true, bikes_availability = false) }

  context 'should respond to' do

    it '#get_transport' do
      expect(available_transport).to respond_to(:get_transport).with(2).arguments
    end

  end

  context '#get_transport should' do

    it 'return array of available transport' do
      expect(available_transport.get_transport(weight, distance)).to be_an_instance_of(Array)
    end

    it 'return available cars' do
      expect(unavailable_bikes.get_transport(weight, distance)).to all(be_an_instance_of(Car))
    end

    it 'return available bikes' do
      expect(unavailable_cars.get_transport(weight = 10, distance = 10)).to all(be_an_instance_of(Bike))
    end

  end

  context 'should rise error' do

    it 'when no available transport' do
      expect { unavailable_transport.get_transport(weight, distance) }.to raise_error(StandardError, 'Sorry we don\'t have available transport now')
    end

    it 'when no available cars' do
      expect { unavailable_cars.get_transport(weight = 90, distance = 200) }.to raise_error(StandardError, 'Sorry we don\'t have available cars now')
    end

  end
end
