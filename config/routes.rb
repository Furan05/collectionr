Rails.application.routes.draw do
  get 'cards/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/collections/pokemon_sets", to: "collections#pokemon_sets", as: "pokemon_sets"

  # resources :collections
  # get "/collections/pokemon", to: "pages#pokemon_collections", as: "pokemon_collections"
  end
