require 'test_helper'
require 'source/episodes_gateway'

class SourceEpisodesGatewayTest < ActionDispatch::IntegrationTest

  setup do
    @gateway = Source::EpisodesGateway.new(ENV['source_api_key'])
    @episodes = @gateway.episodes_for('78107')
    @first_episode = @episodes['Data']['Episode'][0]
  end

  test 'has SeasonNumber' do
    assert_equal '0', @first_episode['SeasonNumber']
  end

  test 'has EpisodeNumber' do
    assert_equal '1', @first_episode['EpisodeNumber']
  end

  test 'has EpisodeName' do
    assert_equal 'Christmas Special (1)', @first_episode['EpisodeName']
  end

  test 'has FirstAired' do
    assert_equal '2003-12-26', @first_episode['FirstAired']
  end

end
