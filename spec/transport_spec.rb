require 'rspec'
require_relative '../transports/transport'

describe 'Transport' do

  it 'should respond to delivery_time method with 1 argument' do
    transport = Transport.new(100, 50, true)
    expect(transport).to respond_to(:delivery_time).with(1).argument
  end

  it 'should return delivery time' do
    transport = Transport.new(100, 50, true)
    expect(transport.delivery_time(500)).to eq(10.0)
  end

  it 'should return float' do
    transport = Transport.new(100, 50, true)
    expect(transport.delivery_time(500)).to be_a(Float)
  end

  it 'should be comparable' do
    transport = Transport.new(100, 50, true)
    expect(transport).to respond_to(:<=>)
  end

  it 'should return true if the max_weight of the first is greater than the max_weight of the second' do
    heavy_transport = Transport.new(100, 50, true)
    light_transport = Transport.new(10, 20, true)
    expect(heavy_transport > light_transport).to be_truthy
  end

  it 'should return false if max_weight of the  first is lover then max_weight of the another' do
    heavy_transport = Transport.new(10, 50, true)
    light_transport = Transport.new(100, 20, true)
    expect(heavy_transport > light_transport).to be_falsey
  end
end
