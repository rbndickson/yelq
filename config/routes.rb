Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root 'pages#main'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :businesses, only: [:index, :new, :create, :show] do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :users, only: [:create, :show, :edit, :update]
end
