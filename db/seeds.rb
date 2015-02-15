Show.destroy_all

Show.create!([{
  display_name: 'Show 1 Display',
  search_name: 'Show 1 Search',
  file_name: 'Show 1 File',
  source_id: '1'
},{
  display_name: 'Show 2 Display',
  search_name: 'Show 2 Search',
  file_name: 'Show 2 File',
  source_id: '2'
}])

Setting.destroy_all

Setting.create!({
  view_link: 'http://example.com?q=%s',
  last_updated: 8.hours.ago
})

Episode.create!([{
  title: 'Show 1 Ep 1',
  season: 1,
  episode_number: 1,
  airdate: 3.weeks.ago.to_datetime,
  show_id: Show.first.id
},{
  title: 'Show 1 Ep 2',
  season: 1,
  episode_number: 2,
  airdate: 2.weeks.ago.to_datetime,
  show_id: Show.first.id
},{
  title: 'Show 1 Ep 3',
  season: 1,
  episode_number: 3,
  airdate: 1.week.ago.to_datetime,
  show_id: Show.first.id
},{
  title: 'Show 2 Ep 1',
  season: 3,
  episode_number: 1,
  airdate: 8.days.ago.to_datetime,
  show_id: Show.second.id
},{
  title: 'Show 2 Ep 2',
  season: 3,
  episode_number: 2,
  airdate: 1.day.ago.to_datetime,
  show_id: Show.second.id
}]);
