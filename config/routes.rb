Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  get 'marketplace/index'
  # Devise routes with custom controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, sign_out_via: [:get, :delete]

  # Root route
  root to: "pages#home"


  resources :users, only: [] do
    get 'profile', on: :member
  end

  resources :cards, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
  end

  resources :offers

  resources :achats, only: [:show, :create] do
    resources :payements, only: [:new]
  end

  resources :payements, only: [:index]

  resources :collections do
    resources :collection_types, only: [:create, :destroy], defaults: { format: :turbo_stream }
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :marketplace, only: [:index]

end
