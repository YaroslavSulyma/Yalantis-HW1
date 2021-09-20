require 'rspec'
require_relative '../app/services/delivery_service'
require 'shared_examples/shared_examples_no_available_transport_spec'
require 'faker'

describe DeliveryService do
  let(:cars_count) { Faker::Number.rand(1..10) }
  let(:bikes_count) { Faker::Number.rand(1..10) }
  let(:bikes_availability) { true }
  let(:bikes_unavailability) { false }
  let(:cars_availability) { true }
  let(:cars_unavailability) { false }
  let(:weight) { 10 }
  let(:distance) { 30 }

  let(:available_transport) do
    described_class.new(cars_count, bikes_count, cars_availability, bikes_availability)
  end

  let(:unavailable_transport) do
    described_class.new(cars_count, bikes_count, cars_unavailability, bikes_unavailability)
  end

  let(:unavailable_cars) do
    described_class.new(cars_count, bikes_count, cars_unavailability, bikes_availability)
  end

  let(:unavailable_bikes) do
    described_class.new(cars_count, bikes_count, cars_availability, bikes_unavailability)
  end

  context 'should respond to' do
    it '#get_transport' do
      expect(available_transport).to respond_to(:get_transport).with(2).arguments
    end
  end

  context '#get_transport should' do
    let(:_weight) { 10 }
    let(:_distance) { 10 }
    it 'return array of available transport' do
      expect(available_transport.get_transport(weight, distance)).to be_an_instance_of(Array)
    end

    it 'return available cars' do
      expect(unavailable_bikes.get_transport(weight, distance)).to all(be_an_instance_of(Car))
    end

    it 'return available bikes' do
      expect(unavailable_cars.get_transport(_weight, _distance)).to all(be_an_instance_of(Bike))
    end
  end

  context 'should rise error' do
    it_behaves_like 'when no available transport' do
      let(:transport) { unavailable_transport }
      let(:message) { 'Sorry we don\'t have available transport now' }
    end

    it_behaves_like 'when no available transport' do
      let(:transport) { unavailable_cars }
      let(:weight) { 90 }
      let(:speed) { 200 }
      let(:message) { 'Sorry we don\'t have available cars now' }
    end
  end
end
