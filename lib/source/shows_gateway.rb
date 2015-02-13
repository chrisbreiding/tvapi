module Source
  class ShowsGateway
    require 'open-uri'

    BASE_URL = "http://thetvdb.com/api/"

    def search(show_name)
      Hash.from_xml(open(URI.escape(search_url(show_name))))
    end

    private

    def search_url(show_name)
      "#{BASE_URL}GetSeries.php?seriesname=#{show_name}"
    end

  end
end
