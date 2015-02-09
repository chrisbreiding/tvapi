class SettingsController < ApplicationController

  def show
    render json: Setting.data, status: 200
  end

end
