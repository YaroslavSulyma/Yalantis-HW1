require 'rspec'
require_relative '../transports/bike'
require_relative '../transports/car'
require 'faker'

describe Bike do
  let(:available) { Faker::Boolean }
  let(:number_of_deliveries) { Faker::Number.rand(50) }
  let(:delivery_cost) { Faker::Number.rand(200) }
  let(:location) { %w[on_route in_garage].sample }

  let(:bike) { described_class.new(available, number_of_deliveries, delivery_cost, location) }

  it 'is inherited from Transport' do
    expect(described_class).to be < Transport
  end

  context 'when instance created' do
    it 'should be an instance of Bike' do
      expect(bike).to be_an_instance_of(described_class)
    end

    it 'should have given attributes' do
      expect(bike).to have_attributes(available: available,
                                      number_of_deliveries: number_of_deliveries,
                                      delivery_cost: delivery_cost,
                                      location: location)
    end
  end

  context '#all' do
    it 'should be an Array' do
      expect(described_class.all).to be_a(Array)
    end

    it 'should be array of Bikes' do
      expect(Bike.all).to all(be_instance_of(described_class))
    end
  end
end
