Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :businesses, only: [:show, :index]
end
