Rails.application.routes.draw do
  get "shipping_address/new"
  get "shipping_address/create"
  get "shipping_address/edit"
  get "shipping_address/update"
  get "carts/add"
  get "catalog/index"
  get "catalog/show"
  get "products/edit"
  get "products/show"
  get "products/index"
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
  get "logout", to: "login#logout"

  get "catalogs", to: "catalog#index"
  get "catalog/:id", to: "catalog#show", as: "catalog"
  get "accessories", to: "catalog#accessory"
  get "search", to: "catalog#search"

  get "cart", to: "carts#index"
  post "cart/add", to: "carts#add", as: "cart_add"
  delete "cart/destroy", to: "carts#destroy", as: "cart_remove"
  get "checkout", to: "carts#checkout"
  post "/guest_checkout", to: "checkouts#guest_checkout"

  get "contact", to: "contact#index"
  post "contact", to: "contact#send_message"

  get "list_category", to: "categories#search"

  resources :orders, only: [ :index, :show, :new, :create ]

  get "profile", to: "users#show"
  get "order_admin", to: "orders#admin_index"
  patch "update_status/:id", to: "orders#update_status", as: "update_status"

  resources :province, only: [ :list ]

  # Maintainer
  resources :products, only: [ :index, :new, :create, :show, :edit, :destroy ]
  resources :categories, only: [ :index, :create, :update, :destroy ]
  resources :users, only: [ :index, :edit, :update, :destroy ] do
    member do
      get :orders
      get :shipping_addresses
    end
    resources :shipping_addresses, only: [ :new, :create, :edit, :update ]
  end
  resources :deliveries, only: [ :index, :create, :update, :destroy ]
  resources :product_type, only: [ :index, :create, :update, :destroy ]
  resources :payment_types, only: [ :index, :create, :update, :destroy ]
  resources :profiles, only: [ :index, :create, :update, :destroy ]
end
