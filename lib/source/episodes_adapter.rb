require 'source/adapter_base'

module Source
  class EpisodesAdapter < AdapterBase

    def episodes(source_data)
      episodes = source_data['Data']['Episode'] || []
      episodes = [episodes] unless episodes.is_a?(Array)
      convert episodes, episode_conversions
    end

    private

    def episode_conversions
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
        transform: ->(date_string) { Time.parse(date_string) }
      }]
    end

  end
end
