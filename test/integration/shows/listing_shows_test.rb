require 'test_helper'

class ListingShowsTest < ActionDispatch::IntegrationTest

  setup do
    Show.create!(display_name: 'Show 1 Display',
                 search_name: 'Show 1 Search',
                 file_name: 'Show 1 File',
                 tvsource_id: '1')
    Show.create!(display_name: 'Show 2 Display',
                 search_name: 'Show 2 Search',
                 file_name: 'Show 2 File',
                 tvsource_id: '2')

    get '/shows'
  end

  test 'status' do
    assert_equal 200, response.status
  end

  test 'type' do
    assert_equal Mime::JSON, response.content_type
  end

  test 'content' do
    shows = json(response.body)[:shows]
    assert_equal Show.count, shows.size
    assert_equal 'Show 1 Display', shows.first[:display_name]
    assert_equal 'Show 2 Display', shows.second[:display_name]
  end

end
