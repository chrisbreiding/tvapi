require 'test_helper'
require 'source/time_adapter'

class SourceShowsAdapterTest < ActiveSupport::TestCase

  setup do
    source_data = {
      'Items' => {
        'Time' => '1423868399'
      }
    }

    adapter = Source::TimeAdapter.new(source_data)
    @current_timestamp = adapter.current_timestamp
  end

  test 'current timestamp is a datetime' do
    assert_instance_of DateTime, @current_timestamp
  end

  test 'current timestamp value' do
    assert_equal DateTime.strptime('1423868399', '%s'), @current_timestamp
  end

end
