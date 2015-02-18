require 'source/shows'
require 'source/episodes'

module Source
  class ShowsUpdater < AdapterBase

    def sync
      settings_data = Setting.data
      last_updated = settings_data.last_updated || 24.hours.ago.to_datetime

      show_ids, time = Shows.new.updated_since(last_updated)
      settings_data.update!(last_updated: time)
      Show.all.each do |show|
        if show_ids.include?(show.source_id)
          update_episodes_for_show(show)
        end
      end
    end

    private

    def update_episodes_for_show(show)
      show.episodes.delete_all
      episodes = Source::Episodes.new.episodes_for(show.source_id)
      show.episodes = Episode.create!(episodes)
    end

  end
end
