require 'rspec'
require_relative '../transports/car'
require_relative '../transports/bike'
require 'faker'

describe Car do
  let(:available) { Faker::Boolean }
  let(:registration_number) { Faker::IDNumber.croatian_id(international: true) }
  let(:number_of_deliveries) { Faker::Number.rand(200) }
  let(:delivery_cost) { Faker::Number.rand(100) }
  let(:location) { %w[on_route in_garage].sample }

  let(:car) { described_class.new(available, registration_number, number_of_deliveries, delivery_cost, location) }

  it 'is inherited from Transport' do
    expect(described_class).to be < Transport
  end

  context 'when instance created' do
    it 'should be an instance of Car' do
      expect(car).to be_an_instance_of(described_class)
    end

    it 'should have given attributes' do
      expect(car).to have_attributes(available: available,
                                     registration_number: registration_number,
                                     number_of_deliveries: number_of_deliveries,
                                     delivery_cost: delivery_cost,
                                     location: location)
    end
  end

  context '#all' do
    it 'should be an Array' do
      expect(described_class.all).to be_a(Array)
    end

    it 'should be array of Cars' do
      expect(Car.all).to all(be_instance_of(described_class))
    end
  end
end
