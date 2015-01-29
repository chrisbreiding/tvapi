require 'test_helper'

class CreatingShowsTest < ActionDispatch::IntegrationTest
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

  test 'valid -> content' do
    create_valid_show
    show = show_from_response
    assert_equal show_attributes[:display_name], show[:display_name]
    assert_equal show_attributes[:search_name], show[:search_name]
    assert_equal show_attributes[:file_name], show[:file_name]
    assert_equal show_attributes[:tvsource_id], show[:tvsource_id]
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

  test 'no tvsource id -> status' do
    create_invalid_show :tvsource_id
    assert_equal 422, response.status
  end


  def create_valid_show
    post '/shows',
      { show: show_attributes }.to_json,
      { 'Content-Type' => 'application/json' }
  end

  def create_invalid_show(invalid_attribute)
    attributes = show_attributes
    attributes[invalid_attribute] = nil
    post '/shows',
      { show: attributes }.to_json,
      { 'Content-Type' => 'application/json' }
  end

  def show_from_response
    json(response.body)[:show]
  end

  def show_attributes
    {
      display_name: 'New Show Display',
      search_name: 'New Show Search',
      file_name: 'New Show File',
      tvsource_id: '1'
    }
  end
end
