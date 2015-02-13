require 'source/gateway_base'

module Source
  class TimeGateway < GatewayBase
    require 'open-uri'

    def current_timestamp
      Hash.from_xml(open(URI.escape(url)))['Items']['Time']
    end

    private

    def url
      "#{base_url}Updates.php?type=none"
    end

  end
end
