require 'test_helper'
require 'source/shows_gateway'

class SourceShowsGatewayUpdatedSinceTest < ActionDispatch::IntegrationTest

  setup do
    gateway = Source::ShowsGateway.new
    @two_hours_ago = 2.hours.ago.to_datetime
    data = gateway.updated_since(@two_hours_ago)
    @time = Time.strptime(data['Items']['Time'], '%s')
    @show_ids = data['Items']['Series']
  end

  test 'time' do
    assert @time > @two_hours_ago, "time (#{@time}) is older than that queried (#{@two_hours_ago})"
  end

  test 'at least one show id' do
    assert @show_ids.count > 0, "expected at least 1 show id but got #{@show_ids.count}"
  end

  test 'show id exists' do
    assert_not_nil @show_ids[0]
  end

end
