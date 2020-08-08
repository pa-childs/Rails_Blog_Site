Rails.application.routes.draw do
  # Static pages
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Articles pages
  resources :articles
  # Below are all the REST routes that can be exposed
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # User pages
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # Login page
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
