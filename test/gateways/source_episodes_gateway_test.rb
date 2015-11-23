require 'test_helper'
require 'source/episodes_gateway'

class SourceEpisodesGatewayTest < ActionDispatch::IntegrationTest

  setup do
    @gateway = Source::EpisodesGateway.new(ENV['source_api_key'])
    @episodes = @gateway.episodes_for('78107')
    @series_info = @episodes['Data']['Series']
    @first_episode = @episodes['Data']['Episode'][0]
  end

  test 'series has poster' do
    assert_equal 'posters/78107-4.jpg', @series_info['poster']
  end

  test 'episode has SeasonNumber' do
    assert_equal '0', @first_episode['SeasonNumber']
  end

  test 'episode has EpisodeNumber' do
    assert_equal '1', @first_episode['EpisodeNumber']
  end

  test 'episode has EpisodeName' do
    assert_equal 'Christmas Special (1)', @first_episode['EpisodeName']
  end

  test 'episode has FirstAired' do
    assert_equal '2003-12-26', @first_episode['FirstAired']
  end

end
