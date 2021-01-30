require 'source/adapter_base'

module Source
  class EpisodesAdapter < AdapterBase

    def episodes(source_data)
      episodes = source_data['data'] || []
      episodes = [episodes] unless episodes.is_a?(Array)
      convert episodes, episode_conversions
    end

    private

    def episode_conversions
      [{
        selector: 'airedSeason',
        property: :season,
        default: '0',
        transform: ->(str) { str.to_i }
      },{
        selector: 'airedEpisodeNumber',
        property: :episode_number,
        default: '0',
        transform: ->(str) { str.to_i }
      },{
        selector: 'episodeName',
        property: :title,
        default: nil
      },{
        selector: 'firstAired',
        property: :airdate,
        default: '1970-01-01',
        transform: ->(date_string) {
          begin
            Time.parse(date_string)
          rescue
            Time.parse('1970-01-01')
          end
        }
      }]
    end

  end
end
