require 'test_helper'
require 'source/shows'

class SearchingSourceShowsTest < ActionDispatch::IntegrationTest

  teardown do
    Source::ShowsGateway.any_instance.unstub(:search)
  end

  test 'status' do
    stub_source_result gateway_search_result
    get '/source_shows', { query: 'chips dub' }, request_headers
    assert_equal 200, response.status
  end

  test 'type' do
    stub_source_result gateway_search_result
    get '/source_shows', { query: 'chips dub' }, request_headers
    assert_equal Mime::JSON, response.content_type
  end

  test 'query with results -> content' do
    stub_source_result gateway_search_result
    get '/source_shows', { query: 'chips dub' }, request_headers

    shows = response_shows
    assert_equal 2, shows.count
    assert_equal 'Chips Dub', shows.first[:name]
    assert_equal 'Chips Dub (UK)', shows.second[:name]
    assert_equal Time.parse('2003-12-02').iso8601, shows.first[:first_aired]
  end

  test 'query with no results -> content' do
    stub_source_empty_result
    get '/source_shows', { query: 'nope' }, request_headers

    assert_equal 0, response_shows.count
  end

  test 'lacking query -> content' do
    stub_source_empty_result
    get '/source_shows', {}, request_headers

    assert_equal 0, response_shows.count
  end

  def stub_source_result(result)
    Source::ShowsGateway.any_instance.stubs(:search).returns(result)
  end

  def stub_source_empty_result
    Source::ShowsGateway.any_instance.stubs(:search).returns({ 'Data' => { 'Series' => [] } })
  end

  def response_shows
    json(response.body)[:source_shows]
  end

end
