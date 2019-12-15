task :keep_alive do
  require 'net/http'

  if ENV['ping_url']
    uri = URI(ENV['ping_url'])
    Net::HTTP.get_response(uri)
  end
end

task :sync => :environment do
  require 'source/shows_updater'
  Source::ShowsUpdater.new.sync
end

task :reset_updated => :environment do
  Setting.data.update!(last_updated: 24.hours.ago.to_datetime)
end

task :get_posters => :environment do
  require 'source/episodes'
  Show.all.each do |show|
    data = Source::Episodes.new.show_info_and_episodes_for(show.source_id)
    show.update!(data[:show_info])
  end
end
