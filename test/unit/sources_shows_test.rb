require 'test_helper'
require 'source/shows'

class SourceShowsTest < ActiveSupport::TestCase

  setup do
    @source_shows = Source::Shows.new
  end

  teardown do
    Source::ShowsGateway.any_instance.unstub(:search)
    Source::ShowsGateway.any_instance.unstub(:updated_since)
  end

  test 'search' do
    Source::ShowsGateway.any_instance.stubs(:search).returns(gateway_search_result)

    assert_equal expected_search_result, @source_shows.search('chips dub')
  end

  test 'updated since' do
    Source::ShowsGateway.any_instance.stubs(:updated_since).returns(updated_shows)
    show_ids, time = @source_shows.updated_since(12.hours.ago.to_datetime)

    assert_equal ['1234', '5678', '9012'], show_ids
    assert_equal Time.strptime('1423868399', '%s'), time
  end

  def expected_search_result
    [{
      id: '1234',
      name: 'Chips Dub',
      description: 'Chips Dub is about...',
      first_aired: Time.parse('2003-12-02'),
      network: 'BAR'
    },{
      id: '5678',
      name: 'Chips Dub (UK)',
      description: 'Veribly, Chips Dub is about...',
      first_aired: Time.parse('2006-02-23'),
      network: 'QUX'
    }]
  end

  def updated_shows
    {
      'Items' => {
        'Time' => '1423868399',
        'Series' => ['1234', '5678', '9012']
      }
    }
  end

end
