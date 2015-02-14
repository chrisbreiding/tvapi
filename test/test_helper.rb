ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'mocha/test_unit'

class ActiveSupport::TestCase
  fixtures :all

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end
