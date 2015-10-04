Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'

  resources :businesses, only: [:show, :index]
  resources :users, only: [:create]
end
