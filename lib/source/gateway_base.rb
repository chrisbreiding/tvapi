module Source
  class GatewayBase

    def base_url
      "http://thetvdb.com/api/"
    end

    def hash_from_xml_url(url)
      Hash.from_xml(open(URI.escape(url)))
    end

  end
end
