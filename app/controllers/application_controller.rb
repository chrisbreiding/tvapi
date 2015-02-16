class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  before_action :ensure_authentication

  private

  def ensure_authentication
    unless ENV['client_api_keys'].split('|').include? request.headers['HTTP_API_KEY']
      head 401
    end
  end
end
