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
},{
  display_name: 'Ruby Ruby',
  search_name: 'My dog',
  file_name: 'My Dog',
  source_id: '3'
}])

Setting.destroy_all

Setting.create!({
  view_link: 'http://example.com?q=%s',
  last_updated: 8.hours.ago
})
