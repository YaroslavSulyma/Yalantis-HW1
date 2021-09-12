require 'rspec'
require_relative '../transports/bike'

describe Bike do
  available = true, number_of_deliveries = 10, delivery_cost = 10, location = 'on_route'
  let(:bike) { described_class.new(available, number_of_deliveries, delivery_cost, location) }

  it 'is inherited from Transport' do
    expect(described_class).to be < Transport
  end

  context 'when instance created' do

    it 'should be an instance of Bike' do
      expect(bike).to be_an_instance_of(described_class)
    end

    it 'should has given attributes' do
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
