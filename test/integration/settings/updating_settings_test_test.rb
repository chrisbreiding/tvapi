require 'test_helper'

class UpdatingSettingsTestTest < ActionDispatch::IntegrationTest
  setup do
    @setting = Setting.create!(setting_attributes)
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

  test 'valid -> record' do
    update_valid
    assert_equal @updated_view_link, @setting.reload.view_link
  end

  test 'updates same record regardless of id' do
    update_valid 2
    assert_equal @updated_view_link, @setting.reload.view_link
  end

  test 'invalid -> status' do
    update_invalid
    assert_equal 422, response.status
  end

  def update_valid(id = 1)
    attributes = setting_attributes
    attributes[:view_link] = @updated_view_link
    put "/settings/#{id}",
      { setting: attributes }.to_json,
      { 'Content-Type' => 'application/json' }
  end

  def update_invalid
    attributes = setting_attributes
    attributes[:view_link] = nil
    put "/settings/1",
      { setting: attributes }.to_json,
      { 'Content-Type' => 'application/json' }
  end

  def setting_from_response
    json(response.body)[:setting]
  end

  def setting_attributes
    {
      view_link: 'the view link',
      last_updated: DateTime.new
    }
  end
end
