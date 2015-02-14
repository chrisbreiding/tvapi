require 'test_helper'
require 'source/shows_adapter'

class SourceShowsAdapterShowsTest < ActiveSupport::TestCase

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
            'seriesid' => nil,
            'SeriesName' => nil,
            'Overview' => nil,
            'FirstAired' => nil,
            'Network' => nil
          }
        ]
      }
    }

    adapter = Source::ShowsAdapter.new
    @shows = adapter.shows(source_data)
    @first_show = @shows[0]
    @second_show = @shows[1]
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

  test 'default id' do
    assert_equal nil, @second_show[:id]
  end

  test 'default name' do
    assert_equal nil, @second_show[:name]
  end

  test 'default description' do
    assert_equal nil, @second_show[:description]
  end

  test 'default first_aired' do
    assert_equal DateTime.parse('1970-01-01'), @second_show[:first_aired]
  end

  test 'default network' do
    assert_equal nil, @second_show[:network]
  end

end
