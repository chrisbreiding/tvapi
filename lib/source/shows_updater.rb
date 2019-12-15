require 'source/shows'
require 'source/episodes'

module Source
  class ShowsUpdater < AdapterBase

    def sync
      settings_data = Setting.data
      last_updated = settings_data.last_updated || 24.hours.ago.to_datetime

      show_ids = Shows.new.updated_since(last_updated)
      Show.all.each do |show|
        if show_ids.include?(show.source_id)
          update_show(show)
        end
      end
      settings_data.update!(last_updated: Time.now)
    end

    private

    def update_show(show)
      show.episodes.delete_all
      data = Source::Episodes.new.show_info_and_episodes_for(show.source_id)
      show.update!(data[:show_info])
      show.episodes = Episode.create!(data[:episodes])
    end

  end
end
