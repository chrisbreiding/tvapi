module Source
  class ShowsAdapter

    def initialize(source_data)
      @source_data = source_data
    end

    def shows
      series = @source_data['Data']['Series']
      series.map do |show|
        conversions.reduce({}) do |memo, c|
          value = show.fetch(c[:selector], c[:default])
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
        selector: 'seriesid',
        property: :id,
        default:  ''
      }, {
        selector: 'SeriesName',
        property: :name,
        default:  'Unknown'
      }, {
        selector: 'Overview',
        property: :description,
        default:  ''
      }, {
        selector: 'FirstAired',
        property: :first_aired,
        default:  '1970-01-01',
        transform: ->(date_string) { DateTime.parse(date_string) }
      }, {
        selector: 'Network',
        property: :network,
        default:  ''
      }]
  end

  end
end
