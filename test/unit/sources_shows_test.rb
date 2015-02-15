require 'test_helper'
require 'source/shows'

class SourceShowsTest < ActiveSupport::TestCase

  teardown do
    Source::ShowsGateway.any_instance.unstub(:search)
  end

  test 'search' do
    Source::ShowsGateway.any_instance.stubs(:search).returns(gateway_search_result)
    source_shows = Source::Shows.new

    assert_equal expected_search_result, source_shows.search('chips dub')
  end

  def expected_search_result
    [{
      id: '1234',
      name: 'Chips Dub',
      description: 'Chips Dub is about...',
      first_aired: DateTime.parse('2003-12-02'),
      network: 'BAR'
    },{
      id: '5678',
      name: 'Chips Dub (UK)',
      description: 'Veribly, Chips Dub is about...',
      first_aired: DateTime.parse('2006-02-23'),
      network: 'QUX'
    }]
  end

end
