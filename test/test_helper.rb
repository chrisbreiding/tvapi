ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'mocha/test_unit'

class ActiveSupport::TestCase

  def request_headers
    { 'HTTP_API_KEY' => 'foo' }
  end

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def gateway_search_result
    {
      'Data' => {
        'Series' => [
          {
            'seriesid' => '1234',
            'SeriesName' => 'Chips Dub',
            'Overview' => 'Chips Dub is about...',
            'FirstAired' => '2003-12-02',
            'Network' => 'BAR'
          },{
            'seriesid' => '5678',
            'SeriesName' => 'Chips Dub (UK)',
            'Overview' => 'Veribly, Chips Dub is about...',
            'FirstAired' => '2006-02-23',
            'Network' => 'QUX'
          }
        ]
      }
    }
  end

  def gateway_episodes_result
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

end
