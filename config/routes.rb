Rails.application.routes.draw do
  # Devise routes with custom controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, sign_out_via: [:get, :delete] 

  # Root route
  root to: "pages#home"

  # User routes
  resources :users, only: [] do
    get 'profile', on: :member
  end

  # Card routes
  resources :cards, only: [:index, :show]

  # Collection routes
  resources :collections do
    resources :collection_types, only: [:create, :destroy], defaults: { format: :turbo_stream }
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
