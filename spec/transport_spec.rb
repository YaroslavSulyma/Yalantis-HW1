require 'rspec'
require_relative '../transports/transport'
require_relative '../transports/car'
require_relative '../transports/bike'

describe Transport do
  max_weight = 100, speed = 50, available = true, number_of_deliveries = 20, delivery_cost = 100, location = 'in_garage'
  let(:transport) { described_class.new(max_weight, speed, available, number_of_deliveries, delivery_cost, location) }

  context 'when instance created' do

    it 'should be an instance of Transport' do
      expect(transport).to be_an_instance_of(described_class)
    end

    it 'should has given attributes' do
      expect(transport).to have_attributes(max_weight: max_weight,
                                           speed: speed,
                                           available: available,
                                           number_of_deliveries: number_of_deliveries,
                                           delivery_cost: delivery_cost,
                                           location: location)
    end

  end

  context 'should respond to' do

    it 'should respond to #all' do
      expect(described_class).to respond_to(:all)
    end

    it 'should respond to #delivery_time' do
      expect(transport).to respond_to(:delivery_time)
    end

    it 'should be comparable' do
      expect(transport).to respond_to(:<=>)
    end

    it 'should respond to #filter_by_'

  end

  context '#all' do

    it 'should be an Array' do
      expect(described_class.all).to be_a(Array)
    end

    it 'should be array of Transport' do
      expect(Transport.all).to all(be_instance_of(described_class))
    end

  end

  context '#delivery_time' do
    distance = 100

    it 'should return float' do
      expect(transport.delivery_time(distance)).to be_a(Float)
    end

    it 'should return correct value' do
      expect(transport.delivery_time(distance)).to eql(Float(distance) / speed)
    end

  end

  context 'comparable method' do
    max_weight_light_t = 10, speed_light_t = 20
    let(:heavy_transport) { described_class.new(max_weight, speed, available, number_of_deliveries, delivery_cost, location) }
    let(:light_transport) { described_class.new(max_weight_light_t, speed_light_t, available, number_of_deliveries, delivery_cost, location) }

    it 'should return true if the max_weight of the first is greater than the max_weight of the second' do
      expect(heavy_transport > light_transport).to be_truthy
    end

    it 'should return false if max_weight of the  first is lover then max_weight of the another' do
      expect(light_transport > heavy_transport).to be_falsey
    end
  end

  context 'should rise error' do

    it 'when given wrong location' do
      expect { described_class.new(max_weight, speed, available, number_of_deliveries, delivery_cost, location = 'foo') }.to raise_error(ArgumentError, 'Location should be on_route or in_garage')
    end

  end

end
