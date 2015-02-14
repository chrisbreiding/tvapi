require 'source/shows'

class SourceShowsController < ApplicationController

  def index
    shows = Source::Shows.new.search(params[:query])
    render json: { source_shows: shows }, status: 200
  end

end
