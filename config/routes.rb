Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'signup', to: 'users#new'

  resources :businesses, only: [:show, :index]
end
