Rails.application.routes.draw do

  resources :shows
  resources :settings, only: [:show, :update]

end
