require 'source/episodes_gateway'
require 'source/episodes_adapter'

module Source
  class Episodes < AdapterBase

    def show_info_and_episodes_for(show_id)
      result = EpisodesGateway.new(ENV['source_api_key']).episodes_for(show_id)
      adapter = EpisodesAdapter.new
      {
        show_info: adapter.show_info(result),
        episodes: adapter.episodes(result)
      }
    end

  end
end
