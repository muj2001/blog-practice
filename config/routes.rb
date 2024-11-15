Rails.application.routes.draw do
  root "public#main"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "posts#index"

  # Routes for user sign up, login, and logout
  resources :users, only: [ :index, :new, :create, :show ] # Sign up, and view user
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Routes for posts, categories, and comments
  resources :posts
  resources :categories
  resources :posts do
    resources :comments, only: [ :create, :destroy ]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  # Rerouting unknown routes to route
  get "*path" => redirect("/")
end
