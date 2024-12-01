Rails.application.routes.draw do
  get "product_type/index"
  get "contact/index"
  post "login/newRegister"
  get "login/register"
  get "login/index"
  get "payment_types/index"
  get "deliveries/index"
  get "statuses/index"
  get "statuses/show"
  get "orders/index"
  get "profiles/index"
  get "profiles/show"
  get "users/index"
  get "users/show"
  get "categories/index"
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  root "home#index"
  get "login", to: "login#index"
  post "login", to: "login#login"
  get "register", to: "login#register"
  post "register", to: "login#newRegister"
  # Maintainer
  resources :categories, only: [ :index, :create, :update, :destroy ]
  resources :users, only: [ :index, :update ]
  resources :deliveries, only: [ :index, :create, :update, :destroy ]
  resources :product_type, only: [ :index, :create, :update, :destroy ]
  resources :payment_types, only: [ :index, :create, :update, :destroy ]

  # get "profiles", to: "profiles#index"
end
