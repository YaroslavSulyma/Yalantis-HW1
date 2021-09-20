require 'rspec'
require_relative '../app/transports/car'
require_relative '../app/transports/bike'
require 'faker'

describe Transport do
  let(:max_weight) { Faker::Number.rand(100) }
  let(:speed) { Faker::Number.rand(200) }
  let(:available) { Faker::Boolean.boolean }
  let(:number_of_deliveries) { Faker::Number.rand(100) }
  let(:delivery_cost) { Faker::Number.rand(200) }
  let(:location) { %w[on_route in_garage].sample }
  let(:count_of_transports) { 4 }

  let(:transport) { described_class.new(max_weight, speed, available, number_of_deliveries, delivery_cost, location) }

  context 'when instance created' do
    it 'should be an instance of Transport' do
      expect(transport).to be_an_instance_of(described_class)
    end

    it 'should have given attributes' do
      expect(transport).to have_attributes(max_weight: max_weight,
                                           speed: speed,
                                           available: available,
                                           number_of_deliveries: number_of_deliveries,
                                           delivery_cost: delivery_cost,
                                           location: location)
    end
  end

  context 'should respond to' do
    it '#all' do
      expect(described_class).to respond_to(:all)
    end

    it '#delivery_time' do
      expect(transport).to respond_to(:delivery_time)
    end

    it 'comparable' do
      expect(transport).to respond_to(:<=>)
    end

    it '#filter_by_max_weight' do
      expect(described_class).to respond_to(:filter_by_max_weight)
    end

    it '#filter_by_speed' do
      expect(described_class).to respond_to(:filter_by_speed)
    end

    it '#filter_by_available' do
      expect(described_class).to respond_to(:filter_by_available)
    end

    it '#filter_by_number_of_deliveries' do
      expect(described_class).to respond_to(:filter_by_number_of_deliveries)
    end

    it '#filter_by_location' do
      expect(described_class).to respond_to(:filter_by_location)
    end

    it '#find_by_max_weight' do
      expect(described_class).to respond_to(:find_by_max_weight)
    end

    it '#find_by_speed' do
      expect(described_class).to respond_to(:find_by_speed)
    end

    it '#find_by_available' do
      expect(described_class).to respond_to(:find_by_available)
    end

    it '#find_by_number_of_deliveries' do
      expect(described_class).to respond_to(:filter_by_number_of_deliveries)
    end

    it '#find_by_location' do
      expect(described_class).to respond_to(:filter_by_location)
    end
  end

  context '#all' do

    let!(:transports) { count_of_transports.times.map { described_class.new(max_weight, speed, available, number_of_deliveries, delivery_cost, location) } }

    after(:each) do
      Transport.instance_variable_set(:@instances, [])
    end

    it 'should be an Array' do
      expect(described_class.all).to be_a(Array)
    end

    it 'should be array of Transport' do
      expect(described_class.all).to all(be_a(described_class))
    end

    it 'should return correct count of values' do
      expect(described_class.all.count).to eql(count_of_transports)
    end

    it 'should return correct values' do
      expect(described_class.all).to eql(transports)
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
    let(:max_weight_light_t) { 10 }
    let(:speed_light_t) { 20 }

    let(:max_weight_heavy_t) { 20 }
    let(:speed_heavy_t) { 30 }

    let(:heavy_transport) {
      described_class.new(max_weight_heavy_t, speed_heavy_t, available, number_of_deliveries, delivery_cost, location) }

    let(:light_transport) {
      described_class.new(max_weight_light_t, speed_light_t, available, number_of_deliveries, delivery_cost, location) }

    it 'should return true if the max_weight of the first is greater than the max_weight of the second' do
      expect(heavy_transport.max_weight > light_transport.max_weight).to be_truthy
    end

    it 'should return false if max_weight of the  first is lower then max_weight of the another' do
      expect(light_transport.max_weight > heavy_transport.max_weight).to be_falsey
    end

    it 'should return true if the speed of the first is greater than the speed of the second' do
      expect(heavy_transport.speed > light_transport.speed).to be_truthy
    end

    it 'should return false if the speed of the first is lower than the speed of the second' do
      expect(heavy_transport.speed < light_transport.speed).to be_falsey
    end

    it 'should return true if speed equal' do
      expect(transport.speed == transport.speed).to be_truthy
    end

    it 'should return true if max_weight and max_distance equal' do
      expect(transport == transport).to be_truthy
    end

    it 'should rise error if transport don`t have max_distance' do
      expect {
        transport <=> transport }.to raise_error(StandardError, "This type of transport don't have distance limit")
    end
  end

  context '#filter_by_' do
    let!(:_transports) do
      [described_class.new(10, 10, true, 100, 50, %w[on_route in_garage].sample),
       described_class.new(20, 10, true, 100, 40, %w[on_route in_garage].sample),
       described_class.new(10, 20, false, 80, 50, %w[on_route in_garage].sample)]
    end

    after(:each) do
      described_class.instance_variable_set(:@instances, [])
    end

    it 'should return array' do
      expect(described_class.filter_by_max_weight(10)).to be_an_instance_of(Array)
    end

    it 'should return array of Transport' do
      expect(described_class.filter_by_max_weight(10)).to all(be_an_instance_of(Transport))
    end

    it 'max_weight should return' do
      expect(described_class.filter_by_max_weight(10)).to eq(_transports.select { |transport| transport.max_weight == 10 })
    end

    it 'speed should return' do
      expect(described_class.filter_by_speed(10)).to eq(_transports.select { |transport| transport.speed == 10 })
    end

    it 'available should return' do
      expect(described_class.filter_by_available(true)).to eq(_transports.select { |transport| transport.available == true })
    end

    it 'number_of_deliveries should return' do
      expect(described_class.filter_by_number_of_deliveries(100)).to eq(_transports.select { |transport| transport.number_of_deliveries == 100 })
    end

    it 'delivery_cost should return' do
      expect(described_class.filter_by_delivery_cost(50)).to eq(_transports.select { |transport| transport.delivery_cost == 50 })
    end

    it 'location should return' do
      expect(Transport.filter_by_location('on_route')).to eq(_transports.select { |transport|
        transport.location == 'on_route' })
    end
  end

  context '#find_by_' do
    let!(:_transports) do
      [described_class.new(10, 10, true, 100, 50, %w[on_route in_garage].sample),
       described_class.new(20, 10, true, 100, 40, %w[on_route in_garage].sample),
       described_class.new(10, 20, false, 80, 50, %w[on_route in_garage].sample)]
    end

    after(:each) do
      described_class.instance_variable_set(:@instances, [])
    end

    it 'should be instance of Transport' do
      expect(described_class.find_by_max_weight(10)).to be_an_instance_of(described_class)
    end

    it 'max_weight should return' do
      expect(described_class.find_by_max_weight(10)).to eq(_transports.find { |transport| transport.max_weight == 10 })
    end

    it 'speed should return' do
      expect(described_class.find_by_speed(10)).to eq(_transports.find { |transport| transport.speed == 10 })
    end

    it 'available should return' do
      expect(described_class.find_by_available(true)).to eq(_transports.find { |transport| transport.available == true })
    end

    it 'number_of_deliveries should return' do
      expect(described_class.find_by_number_of_deliveries(100)).to eq(_transports.find { |transport| transport.number_of_deliveries == 100 })
    end

    it 'delivery_cost should return' do
      expect(described_class.find_by_delivery_cost(50)).to eq(_transports.find { |transport| transport.delivery_cost == 50 })
    end

    it 'location should return' do
      expect(Transport.find_by_location('on_route')).to eq(_transports.find { |transport|
        transport.location == 'on_route' })
    end
  end

  context 'should rise error' do
    it 'when given wrong location' do
      expect do
        described_class.new(max_weight, speed, available, number_of_deliveries, delivery_cost, location = 'foo')
      end.to raise_error(ArgumentError, 'Location should be on_route or in_garage')
    end
  end
end
