require 'test_helper'
require 'source/shows_adapter'

class SourceShowsAdapterShowIdsAndTimeTest < ActiveSupport::TestCase

  setup do
    @adapter = Source::ShowsAdapter.new
  end

  test 'multiple -> show ids' do
    show_ids, _ = @adapter.show_ids_and_time(source_data_multiple)
    assert_equal ['1234', '5678', '9012'], show_ids
  end

  test 'single -> show ids' do
    show_ids, _ = @adapter.show_ids_and_time(source_data_single)
    assert_equal ['3456'], show_ids
  end

  test 'time' do
    _, time = @adapter.show_ids_and_time(source_data_multiple)
    assert_equal DateTime.strptime('1423868399', '%s'), time
  end

  def source_data_multiple
    {
      'Items' => {
        'Time' => '1423868399',
        'Series' => ['1234', '5678', '9012']
      }
    }
  end

  def source_data_single
    {
      'Items' => {
        'Time' => '1423868399',
        'Series' => '3456'
      }
    }
  end

end
