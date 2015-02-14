require 'source/gateway_base'

module Source
  class TimeGateway < GatewayBase
    require 'open-uri'

    def current_timestamp
      hash_from_xml_url(url)
    end

    private

    def url
      "#{base_url}Updates.php?type=none"
    end

  end
end
