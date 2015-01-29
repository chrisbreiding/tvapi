class ShowsController < ApplicationController

  def index
    render json: Show.all, status: 200
  end

end
