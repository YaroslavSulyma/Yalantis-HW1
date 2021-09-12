require 'rspec'
require_relative '../transports/car'
require 'securerandom'

describe Car do
  available = true, registration_number = SecureRandom.uuid, number_of_deliveries = 50, delivery_cost = 100,
              location = 'on_route'
  let(:car) { described_class.new(available, registration_number, number_of_deliveries, delivery_cost, location) }

  it 'is inherited from Transport' do
    expect(described_class).to be < Transport
  end

  context 'when instance created' do

    it 'should be an instance of Car' do
      expect(car).to be_an_instance_of(described_class)
    end

    it 'should has given attributes' do
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
