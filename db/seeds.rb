require 'source/episodes'

Setting.destroy_all
Setting.create!({
  last_updated: 8.hours.ago
})

Show.destroy_all
Show.create!([{
  display_name: 'Portlandia',
  search_name: 'Portlandia',
  file_name: 'Portlandia',
  source_id: '213221'
},{
  display_name: 'Better Call Saul',
  search_name: 'Better Call Saul',
  file_name: 'Better Call Saul',
  source_id: '273181'
},{
  display_name: 'Curb Your Enthusiasm',
  search_name: 'Curb Your Enthusiasm',
  file_name: 'Curb Your Enthusiasm',
  source_id: '76203'
}])

Show.all.each do |show|
  episodes = Source::Episodes.new.episodes_for(show.source_id)
  show.episodes = Episode.create!(episodes)
  show.save
end
