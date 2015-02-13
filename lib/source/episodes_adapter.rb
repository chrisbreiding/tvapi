require 'source/adapter_base'

module Source
  class EpisodesAdapter < AdapterBase

    def initialize(source_data)
      @source_data = source_data
    end

    def episodes
      convert @source_data['Data']['Episode'], conversions
    end

    private

    def conversions
      [{
        selector: 'SeasonNumber',
        property: :season,
        default: '0',
        transform: ->(str) { str.to_i }
      },{
        selector: 'EpisodeNumber',
        property: :episode_number,
        default: '0',
        transform: ->(str) { str.to_i }
      },{
        selector: 'EpisodeName',
        property: :title,
        default: nil
      },{
        selector: 'FirstAired',
        property: :airdate,
        default: '1970-01-01',
        transform: ->(date_string) { DateTime.parse(date_string) }
      }]
    end

  end
end
