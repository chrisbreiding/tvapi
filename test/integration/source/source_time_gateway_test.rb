require 'test_helper'
require 'source/time_gateway'

class SourceTimeGatewayTest < ActionDispatch::IntegrationTest

  setup do
    @gateway = Source::TimeGateway.new
  end

  test 'current timestamp' do
    current_time = DateTime.strptime(@gateway.current_timestamp, '%s')

    assert current_time > 6.hours.ago, 'current time was older than 6 hours ago'
    assert current_time < DateTime.now, 'current time was in the future'
  end

end
