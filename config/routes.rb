Rails.application.routes.draw do

  # Scoped to place locale in URL instead of at the end
  # If now setting included in URL the default is used
  scope "(:locale)", locale: /en|es|fr/ do
    # Static pages
    get '/:locale' => 'pages#home'
    root to: 'pages#home'
    get 'about', to: 'pages#about'

    # Articles pages
    resources :articles

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
end
