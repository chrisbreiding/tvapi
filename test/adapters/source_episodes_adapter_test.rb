require 'test_helper'
require 'source/episodes_adapter'

class SourceEpisodesAdapterTest < ActiveSupport::TestCase

  setup do
    source_data = {
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

    adapter = Source::EpisodesAdapter.new(source_data)
    @episodes = adapter.episodes
    @first_episode = @episodes[0]
    @second_episode = @episodes[1]
  end

  test 'count' do
    assert_equal 3, @episodes.count
  end

  test 'season' do
    assert_equal 1, @first_episode[:season]
  end

  test 'episode number' do
    assert_equal 1, @first_episode[:episode_number]
  end

  test 'title' do
    assert_equal 'Ep One', @first_episode[:title]
  end

  test 'airdate' do
    assert_equal DateTime.parse('2014-01-01'), @first_episode[:airdate]
  end

  test 'default season' do
    assert_equal 0, @second_episode[:season]
  end

  test 'default episode number' do
    assert_equal 0, @second_episode[:episode_number]
  end

  test 'default title' do
    assert_equal '', @second_episode[:title]
  end

  test 'default airdate' do
    assert_equal DateTime.parse('1970-01-01'), @second_episode[:airdate]
  end

end
