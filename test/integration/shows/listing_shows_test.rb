require 'test_helper'
require 'source/source'

class ListingShowsTest < ActionDispatch::IntegrationTest
  test 'status' do
    get '/shows', {}, request_headers
    assert_equal 200, response.status
  end

  test 'type' do
    get '/shows', {}, request_headers
    assert_equal Mime::JSON, response.content_type
  end

  test 'shows for user 1' do
    get '/shows', {}, request_headers

    shows = json(response.body)[:shows]
    assert_equal 2, shows.size
    assert_equal 'Show 1 Display', shows.first[:display_name]
    assert_equal "#{Source.base_url}banners/posters/show1.jpg", shows.first[:poster]
    assert_equal [episodes(:show1ep1).id, episodes(:show1ep2).id, episodes(:show1ep3).id], shows.first[:episode_ids]
    assert_equal 'Show 2 Display', shows.second[:display_name]
    assert_equal [episodes(:show2ep1).id, episodes(:show2ep2).id], shows.second[:episode_ids]
  end

  test 'shows for user 2' do
    get '/shows', {}, request_headers('jane_api_key')

    shows = json(response.body)[:shows]
    assert_equal 1, shows.size
    assert_equal 'Show 2 Display', shows.first[:display_name]
    assert_equal [episodes(:show2ep1).id, episodes(:show2ep2).id], shows.first[:episode_ids]
  end

  test 'episodes for user 1' do
    get '/shows', {}, request_headers

    episodes = json(response.body)[:episodes]
    assert_equal Episode.count, episodes.size
    assert_equal 'Show 1 Ep 1', episodes.first[:title]
    assert_equal 3.weeks.ago.beginning_of_day.to_datetime.iso8601, episodes.first[:airdate]
  end
end
