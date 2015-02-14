require 'test_helper'
require 'source/shows_adapter'

class SourceShowsAdapterShowIdsAndTimeTest < ActiveSupport::TestCase

  setup do
    source_data = {
      'Items' => {
        'Time' => '1423868399',
        'Series' => ['1234', '5678', '9012']
      }
    }

    adapter = Source::ShowsAdapter.new
    @show_ids, @time = adapter.show_ids_and_time(source_data)
  end

  test 'show ids' do
    assert_equal @show_ids, ['1234', '5678', '9012']
  end

  test 'time' do
    assert_equal DateTime.strptime('1423868399', '%s'), @time
  end

end
