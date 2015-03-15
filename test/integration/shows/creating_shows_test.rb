require 'test_helper'
require 'source/episodes_gateway'

class CreatingShowsTest < ActionDispatch::IntegrationTest
  setup do
    Source::EpisodesGateway.any_instance.stubs(:episodes_for).returns(gateway_episodes_result)
  end

  teardown do
    Source::EpisodesGateway.any_instance.unstub(:episodes_for)
  end

  test 'valid -> status' do
    create_valid_show
    assert_equal 201, response.status
  end

  test 'valid -> type' do
    create_valid_show
    assert_equal Mime::JSON, response.content_type
  end

  test 'valid -> location' do
    create_valid_show
    assert_equal show_url(show_from_response[:id]), response.location
  end

  test 'valid -> show content' do
    create_valid_show
    show = show_from_response
    assert_equal show_attributes[:display_name], show[:display_name]
    assert_equal show_attributes[:search_name], show[:search_name]
    assert_equal show_attributes[:file_name], show[:file_name]
    assert_equal show_attributes[:source_id], show[:source_id]
    assert_equal 2, show[:episode_ids].count
  end

  test 'valid -> episodes' do
    create_valid_show
    episodes = episodes_from_response
    assert_equal 'Ep One', episodes[0][:title]
    assert_equal 'Ep Two', episodes[1][:title]
  end

  test 'valid -> viewership' do
    create_valid_show
    assert_includes User.find(users(:user1).id).shows.collect(&:id), show_from_response[:id]
  end

  test 'no display name -> status' do
    create_invalid_show :display_name
    assert_equal 422, response.status
  end

  test 'no search name -> status' do
    create_invalid_show :search_name
    assert_equal 422, response.status
  end

  test 'no file name -> status' do
    create_invalid_show :file_name
    assert_equal 422, response.status
  end

  test 'no source id -> status' do
    create_invalid_show :source_id
    assert_equal 422, response.status
  end

  test 'duplicate source id -> status' do
    Show.create!(show_attributes)
    create_invalid_show :source_id, '1'
    assert_equal 422, response.status
  end

  def create_valid_show
    post '/shows',
      { show: show_attributes }.to_json,
      request_headers.merge({ 'Content-Type' => 'application/json' })
  end

  def create_invalid_show(invalid_attribute, value = nil)
    attributes = show_attributes
    attributes[invalid_attribute] = value
    post '/shows',
      { show: attributes }.to_json,
      request_headers.merge({ 'Content-Type' => 'application/json' })
  end

  def show_from_response
    json(response.body)[:show]
  end

  def episodes_from_response
    json(response.body)[:episodes]
  end

  def show_attributes
    {
      display_name: 'New Show Display',
      search_name: 'New Show Search',
      file_name: 'New Show File',
      source_id: '3'
    }
  end
end
