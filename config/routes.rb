Rails.application.routes.draw do

  resources :shows
  resources :source_shows, only: :index
  resources :settings, only: [:show, :update]
  post '/stats', to: 'stats#track'

end
