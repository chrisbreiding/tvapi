require 'source/adapter_base'

module Source
  class ShowsAdapter < AdapterBase

    def shows(source_data)
      convert source_data['Data']['Series'], show_conversions
    end

    private

    def show_conversions
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
