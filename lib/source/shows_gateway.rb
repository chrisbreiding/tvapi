require 'source/source'

module Source
  class ShowsGateway

    def show_info(show_id)
      Source.request(show_url(show_id))
    end

    def search(show_name)
      Source.request(search_url(show_name))
    end

    def updated_since(datetime)
      url = updated_since_url(datetime)
      print("get updated since: ", url)
      Source.request(url)
    end

    private

    def show_url(show_id)
      "#{Source.api_url}series/#{show_id}"
    end

    def search_url(show_name)
      "#{Source.api_url}search/series?name=#{show_name}"
    end

    def updated_since_url(datetime)
      timestamp = datetime.strftime('%s')
      "#{Source.api_url}updated/query?fromTime=#{timestamp}"
    end
  end
end
