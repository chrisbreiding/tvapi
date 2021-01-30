require 'source/adapter_base'

module Source
  class ShowsAdapter < AdapterBase

    def show(source_data)
      { poster: source_data['data']['poster'] }
    end

    def shows(source_data)
      shows = source_data['data'] || []
      shows = [shows] unless shows.is_a?(Array)

      convert shows, show_conversions
    end

    def show_ids_and_time(source_data)
      updates = source_data['data'] || []
      updates = [updates] unless updates.is_a?(Array)

      updates.map do |update|
        update['id']
      end
    end

    private

    def show_conversions
      [{
        selector: 'id',
        property: :id,
        default:  nil
      }, {
        selector: 'seriesName',
        property: :name,
        default:  nil
      }, {
        selector: 'overview',
        property: :description,
        default:  nil
      }, {
        selector: 'firstAired',
        property: :first_aired,
        default:  '1970-01-01',
        transform: ->(date_string) {
          begin
            Time.parse(date_string)
          rescue
            Time.parse('1970-01-01')
          end
        }
      }, {
        selector: 'network',
        property: :network,
        default:  nil
      }, {
        selector: 'banner',
        property: :banner,
        default:  nil,
        transform: ->(banner) { banner && "#{Source.base_url}banners/#{banner}" }
      }]
    end

  end
end
