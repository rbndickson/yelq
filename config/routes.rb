Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root 'businesses#index'
  get 'home', to: 'businesses#index'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :businesses, only: [:show, :index]
  resources :reviews, only: [:new, :index]
  resources :users, only: [:create, :edit, :update, :show]
end
