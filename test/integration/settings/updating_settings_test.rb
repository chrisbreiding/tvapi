require 'test_helper'

class UpdatingSettingsTest < ActionDispatch::IntegrationTest
  setup do
    @updated_view_link = 'updated view link'
  end

  test 'valid -> status' do
    update_valid
    assert_equal 200, response.status
  end

  test 'valid -> type' do
    update_valid
    assert_equal Mime::JSON, response.content_type
  end

  test 'valid -> content' do
    update_valid
    assert_equal @updated_view_link, setting_from_response[:view_link]
  end

  test 'user 1 -> valid -> record' do
    update_valid
    assert_equal @updated_view_link, User.find(users(:user1).id).view_link
  end

  test 'user 1 -> updates same record regardless of id' do
    update_valid 2
    assert_equal @updated_view_link, User.find(users(:user1).id).view_link
  end

  test 'user 2 -> valid -> record' do
    update_valid 1, 'jane_api_key'
    assert_equal @updated_view_link, User.find(users(:user2).id).view_link
  end

  def update_valid(id = 1, api_key = 'john_api_key')
    put "/settings/#{id}",
      { setting: { view_link: @updated_view_link } }.to_json,
      request_headers(api_key).merge({ 'Content-Type' => 'application/json' })
  end

  def update_invalid
    put "/settings/1",
      { setting: { view_link: nil } }.to_json,
      request_headers.merge({ 'Content-Type' => 'application/json' })
  end

  def setting_from_response
    json(response.body)[:setting]
  end

  def setting_attributes
    { view_link: 'the view link' }
  end
end
