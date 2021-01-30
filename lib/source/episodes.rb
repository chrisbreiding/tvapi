require 'source/episodes_adapter'
require 'source/episodes_gateway'
require 'source/shows_adapter'
require 'source/shows_gateway'

module Source
  class Episodes < AdapterBase

    def show_info_and_episodes_for(show_id)
      show = ShowsGateway.new.show_info(show_id)
      episodes = EpisodesGateway.new.episodes_for(show_id)
      {
        show_info: ShowsAdapter.new.show(show),
        episodes: EpisodesAdapter.new.episodes(episodes)
      }
    end

  end
end
