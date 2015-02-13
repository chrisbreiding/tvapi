module Source
  class EpisodesAdapter

    def initialize(source_data)
      @source_data = source_data
    end

    def episodes
      sodes = @source_data['Data']['Episode']
      sodes.map do |episode|
        conversions.reduce({}) do |memo, c|
          value = episode[c[:selector]] || c[:default]
          if c[:transform]
            value = c[:transform].call value
          end
          memo[c[:property]] = value
          memo
        end
      end
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
        default: ''
      },{
        selector: 'FirstAired',
        property: :airdate,
        default: '1970-01-01',
        transform: ->(date_string) { DateTime.parse(date_string) }
      }]
    end

  end
end
