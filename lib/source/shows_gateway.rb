require 'source/gateway_base'

module Source
  class ShowsGateway < GatewayBase
    require 'open-uri'

    def search(show_name)
      Hash.from_xml(open(URI.escape(search_url(show_name))))
    end

    private

    def search_url(show_name)
      "#{base_url}GetSeries.php?seriesname=#{show_name}"
    end

  end
end
