require 'mixpanel-ruby'

class StatsController < ApplicationController
  before_action :setup

  def track
    @tracker.track(@current_user.api_key, params[:event], params[:data] || {})
    head 204
  end

  private

  def setup
    @tracker = Mixpanel::Tracker.new(ENV['mixpanel_token'])
    @tracker.people.set(@current_user.api_key, {
      'username' => @current_user.username
    })
  end
end
