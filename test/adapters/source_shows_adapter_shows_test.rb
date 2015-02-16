require 'test_helper'
require 'source/shows_adapter'

class SourceShowsAdapterShowsTest < ActiveSupport::TestCase

  setup do
    @adapter = Source::ShowsAdapter.new
  end

  test 'multiple -> count' do
    shows = @adapter.shows(source_data_multiple)
    assert_equal 2, shows.count
  end

  test 'multiple -> id' do
    first_show = @adapter.shows(source_data_multiple)[0]
    assert_equal '1234', first_show[:id]
  end

  test 'multiple -> name' do
    first_show = @adapter.shows(source_data_multiple)[0]
    assert_equal 'Foo', first_show[:name]
  end

  test 'multiple -> description' do
    first_show = @adapter.shows(source_data_multiple)[0]
    assert_equal 'Foo is about...', first_show[:description]
  end

  test 'multiple -> first_aired' do
    first_show = @adapter.shows(source_data_multiple)[0]
    assert_equal Time.parse('2015-02-13'), first_show[:first_aired]
  end

  test 'multiple -> network' do
    first_show = @adapter.shows(source_data_multiple)[0]
    assert_equal 'DEF', first_show[:network]
  end

  test 'default id' do
    second_show = @adapter.shows(source_data_multiple)[1]
    assert_equal nil, second_show[:id]
  end

  test 'default name' do
    second_show = @adapter.shows(source_data_multiple)[1]
    assert_equal nil, second_show[:name]
  end

  test 'default description' do
    second_show = @adapter.shows(source_data_multiple)[1]
    assert_equal nil, second_show[:description]
  end

  test 'default first_aired' do
    second_show = @adapter.shows(source_data_multiple)[1]
    assert_equal Time.parse('1970-01-01'), second_show[:first_aired]
  end

  test 'default network' do
    second_show = @adapter.shows(source_data_multiple)[1]
    assert_equal nil, second_show[:network]
  end

  test 'single -> id' do
    first_show = @adapter.shows(source_data_single)[0]
    assert_equal '1234', first_show[:id]
  end

  test 'single -> name' do
    first_show = @adapter.shows(source_data_single)[0]
    assert_equal 'Foo', first_show[:name]
  end

  test 'single -> description' do
    first_show = @adapter.shows(source_data_single)[0]
    assert_equal 'Foo is about...', first_show[:description]
  end

  test 'single -> first_aired' do
    first_show = @adapter.shows(source_data_single)[0]
    assert_equal Time.parse('2015-02-13'), first_show[:first_aired]
  end

  test 'single -> network' do
    first_show = @adapter.shows(source_data_single)[0]
    assert_equal 'DEF', first_show[:network]
  end

  def source_data_multiple
    {
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
  end

  def source_data_single
    {
      'Data' => {
        'Series' => {
          'seriesid' => '1234',
          'SeriesName' => 'Foo',
          'Overview' => 'Foo is about...',
          'FirstAired' => '2015-02-13',
          'Network' => 'DEF'
        }
      }
    }
  end

end
