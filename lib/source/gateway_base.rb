module Source
  class GatewayBase

    def hash_from_xml_url(url)
      Hash.from_xml(open(URI.escape(url)))
    end

  end
end
