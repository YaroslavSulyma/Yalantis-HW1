require 'rspec'
require_relative '../services/delivery_service'

describe 'DeliveryService' do

  it 'available transport should be an array' do
    delivery_service = DeliveryService.new
    transport = delivery_service.get_transport(100, 20)
    expect(transport).to be_an_instance_of(Array)
  end

  it 'object should respond to get_transport method' do
    delivery_service = DeliveryService.new
    expect(delivery_service).to respond_to(:get_transport).with(2).arguments
  end

  it 'available transport array should be an instance of Car' do
    delivery_service = DeliveryService.new
    transport = delivery_service.get_transport(100, 20)
    expect(transport).to all(be_an_instance_of(Car))
  end

  it 'available transport array should be an instance of Bike' do
    delivery_service = DeliveryService.new
    transport = delivery_service.get_transport(10, 3)
    expect(transport).to all(be_an_instance_of(Bike))
  end

  it 'should be an exception about unavailable transport' do
    delivery_service = DeliveryService.new([], [])
    expect { delivery_service.get_transport(10, 3) }.to raise_error(StandardError, "Sorry we don't have available transport now")
  end

  it 'should be an exception about unavailable cars' do
    delivery_service = DeliveryService.new([])
    expect { delivery_service.get_transport(1000, 100) }.to raise_error(StandardError, "Sorry we don't have available cars now")
  end

  it 'park should contain all transport' do
    delivery_service = DeliveryService.new
    park = delivery_service.park
    expect(park).to eq(delivery_service.cars + delivery_service.bikes)
  end
end
