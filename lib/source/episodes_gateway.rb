require "source/source"

module Source
  class EpisodesGateway
    def episodes_for(show_id, prev_data = [], page = 1)
      result = Source.request(episodes_url(show_id, page))
      data = prev_data.concat(result["data"])

      if result["links"]["last"] == page
        return { "data" => data }
      end

      episodes_for(show_id, data, page + 1)
    end

    private

    def episodes_url(show_id, page)
      "#{Source.api_url}series/#{show_id}/episodes?page=#{page}"
    end
  end
end
