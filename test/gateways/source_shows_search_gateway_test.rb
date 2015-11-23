require 'test_helper'
require 'source/shows_gateway'

class SourceShowsGatewaySearchTest < ActionDispatch::IntegrationTest

  setup do
    gateway = Source::ShowsGateway.new
    shows = gateway.search('the office')
    @first_show = shows['Data']['Series'][0]
  end

  test 'has seriesid' do
    assert_equal '78107', @first_show['seriesid']
  end

  test 'has SeriesName' do
    assert_equal 'The Office', @first_show['SeriesName']
  end

  test 'has Overview' do
    assert_match /A mockumentary about life/, @first_show['Overview']
  end

  test 'has FirstAired' do
    assert_equal '2001-07-01', @first_show['FirstAired']
  end

  test 'has Network' do
    assert_equal 'BBC Two', @first_show['Network']
  end

end
