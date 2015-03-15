require 'test_helper'

class DeletingShowsTest < ActionDispatch::IntegrationTest
  setup do
    @show1 = shows(:show1)
    @show2 = shows(:show2)
  end

  test 'status' do
    delete "/shows/#{@show1.id}", {}, request_headers
    assert_equal 204, response.status
  end

  test 'has user(s) -> deletes viewership' do
    delete "/shows/#{@show2.id}", {}, request_headers
    assert_nil Viewership.where(user_id: users(:user1).id, show_id: @show2.id).first
  end

  test 'has user(s) -> leaves show' do
    delete "/shows/#{@show2.id}", {}, request_headers
    assert_nothing_raised(ActiveRecord::RecordNotFound) { Show.find(@show2.id) }
  end

  test 'lacks user -> deletes viewership and show' do
    delete "/shows/#{@show1.id}", {}, request_headers
    assert_nil Viewership.where(user_id: users(:user1).id, show_id: @show1.id).first
    assert_raises(ActiveRecord::RecordNotFound) { Show.find(@show1.id) }
    assert_equal 1, Show.count
  end
end
