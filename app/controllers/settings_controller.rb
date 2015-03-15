class SettingsController < ApplicationController

  def show
    render json: setting, status: 200
  end

  def update
    if @current_user.update(setting_params)
      render json: setting, status: 200
    else
      render json: setting.errors, status: 422
    end
  end

  private

  def setting
    {
      setting: {
        id: 1,
        last_updated: Setting.data.last_updated,
        view_link: @current_user.view_link
      }
    }
  end

  def setting_params
    params.require(:setting).permit(:view_link)
  end

end
