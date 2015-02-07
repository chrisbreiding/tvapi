require 'test_helper'

class DeletingShowsTest < ActionDispatch::IntegrationTest
  setup do
    @show1 = Show.create!(display_name: 'Show 1 Display',
                 search_name: 'Show 1 Search',
                 file_name: 'Show 1 File',
                 source_id: '1')
    @show2 = Show.create!(display_name: 'Show 2 Display',
                 search_name: 'Show 2 Search',
                 file_name: 'Show 2 File',
                 source_id: '2')

    delete "/shows/#{@show1.id}"
  end

  test 'status' do
    assert_equal 204, response.status
  end

  test 'deletion' do
    assert_equal 1, Show.count
  end
end
