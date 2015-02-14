require 'source/gateway_base'

module Source
  class ShowsGateway < GatewayBase
    require 'open-uri'

    def search(show_name)
      hash_from_xml_url(search_url(show_name))
    end

    def updated_since(datetime)
      hash_from_xml_url(updated_since_url(datetime))
    end

    private

    def search_url(show_name)
      "#{base_url}GetSeries.php?seriesname=#{show_name}"
    end

    def updated_since_url(datetime)
      timestamp = datetime.strftime('%s')
      "#{base_url}/Updates.php?type=all&time=#{timestamp}"
    end

  end
end
