class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  before_action :set_current_user
  before_action :ensure_authentication

  private

  def set_current_user
    @current_user = User.where(api_key: request.headers['HTTP_API_KEY']).first
  end

  def ensure_authentication
    head 401 if @current_user.nil?
  end
end
