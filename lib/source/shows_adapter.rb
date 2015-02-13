require 'source/adapter_base'

module Source
  class ShowsAdapter < AdapterBase

    def initialize(source_data)
      @source_data = source_data
    end

    def shows
      convert @source_data['Data']['Series'], conversions
    end

    private

    def conversions
      [{
        selector: 'seriesid',
        property: :id,
        default:  nil
      }, {
        selector: 'SeriesName',
        property: :name,
        default:  nil
      }, {
        selector: 'Overview',
        property: :description,
        default:  nil
      }, {
        selector: 'FirstAired',
        property: :first_aired,
        default:  '1970-01-01',
        transform: ->(date_string) { DateTime.parse(date_string) }
      }, {
        selector: 'Network',
        property: :network,
        default:  nil
      }]
  end

  end
end
