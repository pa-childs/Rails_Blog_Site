Rails.application.routes.draw do
  # Static pages
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Articles pages
  resources :articles
  # Below are all the REST routes that can be exposed
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # User pagess
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # Login pages
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Categories pages
  resources :categories, except: [:destroy]
end
