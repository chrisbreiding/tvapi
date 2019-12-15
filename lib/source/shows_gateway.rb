require 'source/source'
require 'source/gateway_base'

module Source
  class ShowsGateway < GatewayBase
    require 'open-uri'

    def search(show_name)
      hash_from_xml_url(search_url(show_name))
    end

    def updated_since(datetime)
      url = updated_since_url(datetime)
      print("get updated since: ", url)
      hash_from_xml_url(url)
    end

    private

    def search_url(show_name)
      "#{Source.api_url}GetSeries.php?seriesname=#{show_name}"
    end

    def updated_since_url(datetime)
      timestamp = datetime.strftime('%s')
      "#{Source.api_url}Updates.php?type=all&time=#{timestamp}"
    end
  end
end
