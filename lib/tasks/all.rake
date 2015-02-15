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
