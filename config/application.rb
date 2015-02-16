require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tvapi
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
      end
    end
  end
end

ActiveModel::Serializer.setup do |config|
  config.embed = :ids
  config.embed_in_root = true
end

ActiveSupport::JSON::Encoding.time_precision = 0
