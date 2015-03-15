require 'source/episodes'

class ShowsController < ApplicationController

  def index
    render json: @current_user.shows, status: 200
  end

  def create
    show = Show.new(show_params)
    episodes = Source::Episodes.new.episodes_for(show.source_id)
    show.episodes = Episode.create!(episodes)

    if show.save
      @current_user.shows << show
      render json: show, status: 201, location: show
    else
      render json: show.errors, status: 422
    end
  end

  def update
    show = Show.find(params[:id])
    if show.update(show_params)
      render json: show, status: 200
    else
      render json: show.errors, status: 422
    end
  end

  def destroy
    show = Show.find(params[:id])
    @current_user.shows.delete show
    show.destroy if show.users.empty?
    head 204
  end

  private

  def show_params
    params.require(:show).permit(:display_name,
                                 :search_name,
                                 :file_name,
                                 :source_id)
  end

end
