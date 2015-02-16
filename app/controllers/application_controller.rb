class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  before_action :ensure_authentication

  private

  def ensure_authentication
    unless ENV['client_api_keys'].split('|').include? request.headers['api_key']
      head 401
    end
  end
end
