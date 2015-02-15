require 'test_helper'

class ListingShowsTest < ActionDispatch::IntegrationTest
  setup do
    show1 = Show.create!(display_name: 'Show 1 Display',
                         search_name: 'Show 1 Search',
                         file_name: 'Show 1 File',
                         source_id: '1')
    show2 = Show.create!(display_name: 'Show 2 Display',
                         search_name: 'Show 2 Search',
                         file_name: 'Show 2 File',
                         source_id: '2')

    @ep1 = Episode.create!(title: 'Show 1 Ep 1',
                           season: 1,
                           episode_number: 1,
                           airdate: 3.weeks.ago.to_datetime,
                           show_id: show1.id)
    @ep2 = Episode.create!(title: 'Show 1 Ep 2',
                           season: 1,
                           episode_number: 2,
                           airdate: 2.weeks.ago.to_datetime,
                           show_id: show1.id)
    @ep3 = Episode.create!(title: 'Show 1 Ep 3',
                           season: 1,
                           episode_number: 3,
                           airdate: 1.week.ago.to_datetime,
                           show_id: show1.id)
    @ep4 = Episode.create!(title: 'Show 2 Ep 1',
                           season: 3,
                           episode_number: 1,
                           airdate: 8.days.ago.to_datetime,
                           show_id: show2.id)
    @ep5 = Episode.create!(title: 'Show 2 Ep 2',
                           season: 3,
                           episode_number: 2,
                           airdate: 1.day.ago.to_datetime,
                           show_id: show2.id)

    get '/shows'
  end

  test 'status' do
    assert_equal 200, response.status
  end

  test 'type' do
    assert_equal Mime::JSON, response.content_type
  end

  test 'shows' do
    shows = json(response.body)[:shows]
    assert_equal Show.count, shows.size
    assert_equal 'Show 1 Display', shows.first[:display_name]
    assert_equal [@ep1.id, @ep2.id, @ep3.id], shows.first[:episode_ids]
    assert_equal 'Show 2 Display', shows.second[:display_name]
    assert_equal [@ep4.id, @ep5.id], shows.second[:episode_ids]
  end

  test 'episodes' do
    episodes = json(response.body)[:episodes]
    assert_equal Episode.count, episodes.size
    assert_equal 'Show 1 Ep 1', episodes.first[:title]
  end
end
