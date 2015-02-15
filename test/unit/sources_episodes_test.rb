require 'test_helper'
require 'source/episodes'

class SourceEpisodesTest < ActiveSupport::TestCase

  teardown do
    Source::EpisodesGateway.any_instance.unstub(:episodes_for)
  end

  test 'search' do
    Source::EpisodesGateway.any_instance.stubs(:episodes_for).returns(gateway_result)
    episodes = Source::Episodes.new

    assert_equal expected_result, episodes.episodes_for('12345')
  end

  def gateway_result
    {
      'Data' => {
        'Episode' => [
          {
            'SeasonNumber' => '1',
            'EpisodeNumber' => '1',
            'FirstAired' => '2014-01-01',
            'EpisodeName' => 'Ep One'
          },{
            'SeasonNumber' => '1',
            'EpisodeNumber' => '2',
            'FirstAired' => '2014-01-15',
            'EpisodeName' => 'Ep Two'
          }
        ]
      }
    }
  end

  def expected_result
    [{
      season: 1,
      episode_number: 1,
      airdate: DateTime.parse('2014-01-01'),
      title: 'Ep One'
    },{
      season: 1,
      episode_number: 2,
      airdate: DateTime.parse('2014-01-15'),
      title: 'Ep Two'
    }]
  end

end
