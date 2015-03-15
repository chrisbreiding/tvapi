require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  test 'must have api key' do
    get '/shows'
    assert_equal 401, response.status
  end

  test 'must be valid api key' do
    get '/shows', {}, request_headers('nope')
    assert_equal 401, response.status
  end

end
