require 'source/adapter_base'

module Source
  class ShowsAdapter < AdapterBase

    def shows(source_data)
      shows = source_data['Data']['Series'] || []
      shows = [shows] unless shows.is_a?(Array)

      convert shows, show_conversions
    end

    def show_ids_and_time(source_data)
      show_ids = source_data['Items']['Series'] || []
      show_ids = [show_ids] unless show_ids.is_a?(Array)
      timestamp = source_data['Items']['Time']

      [show_ids, Time.strptime(timestamp, '%s')]
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
        transform: ->(date_string) { Time.parse(date_string) }
      }, {
        selector: 'Network',
        property: :network,
        default:  nil
      }]
    end

  end
end
