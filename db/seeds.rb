require 'source/episodes'

Setting.destroy_all
Setting.create!({
  last_updated: 8.hours.ago
})

User.destroy_all
User.create!([{
  username: 'john',
  api_key: 'john_api_key',
  view_link: 'http://example.com/john?q=%s'
},{
  username: 'jane',
  api_key: 'jane_api_key',
  view_link: 'http://example.com/jane?q=%s'
}])

Show.destroy_all
Show.create!([{
  display_name: 'It\'s Always Sunny in Philadelphia',
  search_name: 'Always Sunny in Philadelphia',
  file_name: 'It\'s Always Sunny in Philadelphia',
  source_id: '75805'
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

Viewership.destroy_all
Viewership.create!([{
  user_id: User.first.id,
  show_id: Show.first.id
},{
  user_id: User.first.id,
  show_id: Show.second.id
},{
  user_id: User.first.id,
  show_id: Show.third.id
},{
  user_id: User.second.id,
  show_id: Show.second.id
}])

Show.all.each do |show|
  episodes = Source::Episodes.new.episodes_for(show.source_id)
  show.episodes = Episode.create!(episodes)
  show.save
end
