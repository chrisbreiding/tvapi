require 'test_helper'
require 'source/shows_updater'

class SourceShowsUpdaterTest < ActiveSupport::TestCase

  setup do
    Show.create!([{
      display_name: 'Foo',
      search_name: 'Foo',
      file_name: 'Foo',
      source_id: '1234'
    },{
      display_name: 'Bar',
      search_name: 'Bar',
      file_name: 'Bar',
      source_id: '5678'
    }])

    Source::ShowsGateway.any_instance.stubs(:updated_since).returns(updated_shows)
    Source::EpisodesGateway.any_instance.stubs(:episodes_for).returns(gateway_episodes_result)

    @expected_last_updated = Time.strptime('1423868399', '%s')
    @updater = Source::ShowsUpdater.new
  end

  teardown do
    Source::ShowsGateway.any_instance.unstub(:updated_since)
    Source::EpisodesGateway.any_instance.unstub(:episodes_for)
  end

  test 'episodes count' do
    @updater.sync
    assert_equal 2, Show.first.episodes.count
    assert_equal 2, Show.second.episodes.count
  end

  test 'episodes content' do
    @updater.sync
    assert_equal 'Ep Two', Show.first.episodes.second.title
    assert_equal 'Ep One', Show.second.episodes.first.title
  end

  test 'last updated' do
    @updater.sync
    assert_equal @expected_last_updated, Setting.data.last_updated
  end

  test 'first time' do
    Source::ShowsGateway.any_instance.expects(:updated_since).returns(updated_shows)
    @updater.sync
    assert_equal @expected_last_updated, Setting.data.last_updated
  end

  test 'subsequent times' do
    last_updated = 12.hours.ago.to_datetime
    Setting.data.update!(last_updated: last_updated)
    Source::ShowsGateway.any_instance.expects(:updated_since).returns(updated_shows)
    @updater.sync
    assert_equal @expected_last_updated, Setting.data.last_updated
  end

  def updated_shows
    {
      'Items' => {
        'Time' => '1423868399',
        'Series' => ['1234', '5678']
      }
    }
  end

end
