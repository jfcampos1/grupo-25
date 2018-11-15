Rails.application.routes.draw do
  mount Dashing::Engine, at: Dashing.config.engine_path
  resources :dashboards
  resources :favorites
  resources :subscriptions
  resources :coments
  resources :posts do
    resources :coments
    resources :postratings
    resources :favorites
  end
  resources :coments do
    resources :comentratings
  end
  resources :moderator_requests
  resources :moderators
  get 'subscription/create'
  get 'subscription/destroy'
  get 'search/create'
  resources :users do
    member do
      get :following
      get :followers
    end
  end

  resources :temas do
    resources :moderator_requests
    resources :moderators
    resources :subscriptions
    resources :posts
  end

  resources :relationships,       only: [:create, :destroy]
  resources :foros do
    resources :temas
  end
  get 'sessions/new'

  get 'foros/foros'

  post 'search/create' => 'search#create', as: 'search_something'

  root   'static_pages#home'
  get    '/dashboards', to: 'dashboards#index'
  get    '/search',  to: 'search#index'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  get    '/ranking',   to: 'users#ranking'

  post '/signup',  to: 'users#create'
  post '/create',  to: 'coments#create'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users do
    member do
      get :confirm_email
    end
  end

  get 'auth/:provider/callback' => 'sessions#callback'
end
