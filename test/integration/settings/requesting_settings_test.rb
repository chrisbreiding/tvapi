require 'test_helper'

class RequestingSettingsTest < ActionDispatch::IntegrationTest
  setup do
    @date = DateTime.new
    Setting.create!(view_link: 'Anything', last_updated: @date)
  end

  test 'status' do
    request 1
    assert_equal 200, response.status
  end

  test 'type' do
    request 1
    assert_equal Mime::JSON, response.content_type
  end

  test 'content' do
    request 1
    setting = json(response.body)[:setting]
    assert_equal 'Anything', setting[:view_link]
    assert_equal @date, setting[:last_updated]
  end

  test 'same content regardless of id' do
    request 2
    setting = json(response.body)[:setting]
    assert_equal 'Anything', setting[:view_link]
    assert_equal @date, setting[:last_updated]
  end

  def request(id)
    get "/settings/#{id}"
  end
end
