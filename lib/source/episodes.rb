require 'source/episodes_gateway'
require 'source/episodes_adapter'

module Source
  class Episodes < AdapterBase

    def episodes_for(show_id)
      result = EpisodesGateway.new(ENV['source_api_key']).episodes_for(show_id)
      EpisodesAdapter.new.episodes(result)
    end

  end
end
