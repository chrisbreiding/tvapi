require 'test_helper'

class UpdatingShowsTest < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:show1)
    @updated_name = 'Updated Show Display'
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
    assert_equal @updated_name, show_from_response[:display_name]
  end

  test 'valid -> record' do
    update_valid
    assert_equal @updated_name, @show.reload.display_name
  end

  test 'invalid -> status' do
    update_invalid
    assert_equal 422, response.status
  end

  def update_valid
    attributes = @show.attributes
    attributes[:display_name] = @updated_name
    put "/shows/#{@show.id}",
      { show: attributes }.to_json,
      request_headers.merge({ 'Content-Type' => 'application/json' })
  end

  def update_invalid
    attributes = @show.attributes
    attributes[:display_name] = nil
    put "/shows/#{@show.id}",
      { show: attributes }.to_json,
      request_headers.merge({ 'Content-Type' => 'application/json' })
  end

  def show_from_response
    json(response.body)[:show]
  end
end
