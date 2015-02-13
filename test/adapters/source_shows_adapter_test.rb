require 'test_helper'
require 'source/shows_adapter'

class SourceShowsAdapterTest < ActiveSupport::TestCase

  setup do
    source_data = {
      'Data' => {
        'Series' => [
          {
            'seriesid' => '1234',
            'SeriesName' => 'Foo',
            'Overview' => 'Foo is about...',
            'FirstAired' => '2015-02-13',
            'Network' => 'DEF'
          },{
            'seriesid' => '5678',
            'SeriesName' => 'Bar',
            'Overview' => 'Bar is about...',
            'FirstAired' => '2012-11-02',
            'Network' => 'GHI'
          }
        ]
      }
    }

    adapter = Source::ShowsAdapter.new(source_data)
    @shows = adapter.shows
    @first_show = @shows[0]
  end

  test 'count' do
    assert_equal 2, @shows.count
  end

  test 'id' do
    assert_equal '1234', @first_show[:id]
  end

  test 'name' do
    assert_equal 'Foo', @first_show[:name]
  end

  test 'description' do
    assert_equal 'Foo is about...', @first_show[:description]
  end

  test 'first_aired' do
    assert_equal DateTime.parse('2015-02-13'), @first_show[:first_aired]
  end

  test 'network' do
    assert_equal 'DEF', @first_show[:network]
  end

end
