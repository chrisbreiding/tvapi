require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  test 'must be authenticated' do
    get '/shows'
    assert_equal 401, response.status
  end

end
