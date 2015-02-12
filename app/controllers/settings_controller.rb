class SettingsController < ApplicationController

  def show
    render json: Setting.data, status: 200
  end

  def update
    setting = Setting.data
    if setting.update(setting_params)
      render json: setting, status: 200
    else
      render json: setting.errors, status: 422
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:view_link)
  end

end
