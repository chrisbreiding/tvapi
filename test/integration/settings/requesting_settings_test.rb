require 'test_helper'

class RequestingSettingsTest < ActionDispatch::IntegrationTest
  setup do
    @date = Date.today.beginning_of_day
  end

  test 'status' do
    request 1
    assert_equal 200, response.status
  end

  test 'type' do
    request 1
    assert_equal Mime::JSON, response.content_type
  end

  test 'user 1 -> content' do
    request 1
    setting = json(response.body)[:setting]
    assert_equal 'john_view_link', setting[:view_link]
    assert_equal @date.iso8601, setting[:last_updated]
  end

  test 'user 1 -> same content regardless of id' do
    request 2
    setting = json(response.body)[:setting]
    assert_equal 'john_view_link', setting[:view_link]
    assert_equal @date.iso8601, setting[:last_updated]
  end

  test 'user 2 -> content' do
    request 1, 'jane_api_key'
    setting = json(response.body)[:setting]
    assert_equal 'jane_view_link', setting[:view_link]
    assert_equal @date.iso8601, setting[:last_updated]
  end

  def request(id, api_key = 'john_api_key')
    get "/settings/#{id}", {}, request_headers(api_key)
  end
end
