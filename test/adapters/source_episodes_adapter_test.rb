require 'test_helper'
require 'source/episodes_adapter'

class SourceEpisodesAdapterTest < ActiveSupport::TestCase

  setup do
    @adapter = Source::EpisodesAdapter.new
  end

  test 'multiple -> count' do
    episodes = @adapter.episodes(source_data_multiple)
    assert_equal 3, episodes.count
  end

  test 'multiple -> season' do
    first_episode = @adapter.episodes(source_data_multiple)[0]
    assert_equal 1, first_episode[:season]
  end

  test 'multiple -> episode number' do
    first_episode = @adapter.episodes(source_data_multiple)[0]
    assert_equal 1, first_episode[:episode_number]
  end

  test 'multiple -> title' do
    first_episode = @adapter.episodes(source_data_multiple)[0]
    assert_equal 'Ep One', first_episode[:title]
  end

  test 'multiple -> airdate' do
    first_episode = @adapter.episodes(source_data_multiple)[0]
    assert_equal DateTime.parse('2014-01-01'), first_episode[:airdate]
  end

  test 'default season' do
    second_episode = @adapter.episodes(source_data_multiple)[1]
    assert_equal 0, second_episode[:season]
  end

  test 'default episode number' do
    second_episode = @adapter.episodes(source_data_multiple)[1]
    assert_equal 0, second_episode[:episode_number]
  end

  test 'default title' do
    second_episode = @adapter.episodes(source_data_multiple)[1]
    assert_equal nil, second_episode[:title]
  end

  test 'default airdate' do
    second_episode = @adapter.episodes(source_data_multiple)[1]
    assert_equal DateTime.parse('1970-01-01'), second_episode[:airdate]
  end

  test 'single -> count' do
    episodes = @adapter.episodes(source_data_single)
    assert_equal 1, episodes.count
  end

  test 'single -> season' do
    first_episode = @adapter.episodes(source_data_single)[0]
    assert_equal 1, first_episode[:season]
  end

  test 'single -> episode number' do
    first_episode = @adapter.episodes(source_data_single)[0]
    assert_equal 1, first_episode[:episode_number]
  end

  test 'single -> title' do
    first_episode = @adapter.episodes(source_data_single)[0]
    assert_equal 'Ep One', first_episode[:title]
  end

  test 'single -> airdate' do
    first_episode = @adapter.episodes(source_data_single)[0]
    assert_equal DateTime.parse('2014-01-01'), first_episode[:airdate]
  end

  def source_data_multiple
    {
      'Data' => {
        'Episode' => [
          {
            'SeasonNumber' => '1',
            'EpisodeNumber' => '1',
            'FirstAired' => '2014-01-01',
            'EpisodeName' => 'Ep One'
          },{
            'SeasonNumber' => nil,
            'EpisodeNumber' => nil,
            'FirstAired' => nil,
            'EpisodeName' => nil
          },{
            'SeasonNumber' => '1',
            'EpisodeNumber' => '3',
            'FirstAired' => '2014-01-15',
            'EpisodeName' => 'Ep three'
          }
        ]
      }
    }
  end

  def source_data_single
    {
      'Data' => {
        'Episode' => {
          'SeasonNumber' => '1',
          'EpisodeNumber' => '1',
          'FirstAired' => '2014-01-01',
          'EpisodeName' => 'Ep One'
        }
      }
    }
  end

end
