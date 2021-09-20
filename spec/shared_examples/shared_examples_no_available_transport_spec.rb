require 'rspec'

shared_examples_for 'when no available transport' do
  it do
    expect { transport.get_transport(weight, distance) }.to raise_error(StandardError, message)
  end
end
