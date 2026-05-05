Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  # Public routes
  root "pages#home"
  get "menu", to: "menu#index"
  get "about", to: "pages#about"
  get "contact", to: "contact#index"
  resources :reservations, only: [ :new, :create ]

  # Cart
  get "cart", to: "cart#show"
  post "cart/add", to: "cart#add", as: :cart_add
  post "cart/add_meal", to: "cart#add_meal", as: :cart_add_meal
  patch "cart/update", to: "cart#update", as: :cart_update
  delete "cart/remove/:menu_item_id", to: "cart#remove", as: :cart_remove
  delete "cart/remove_meal/:meal_index", to: "cart#remove_meal", as: :cart_remove_meal
  patch "cart/swap_drink", to: "cart#swap_drink", as: :cart_swap_drink
  delete "cart/clear", to: "cart#clear", as: :cart_clear

  # Orders
  resources :orders, only: [ :new, :create ]
  get "orders/:id/confirmation", to: "orders#confirmation", as: :order_confirmation

  # Admin
  namespace :admin do
    root "dashboard#index"
    resources :menu_categories, except: [ :show ]
    resources :menu_items, except: [ :show ]
    resource :hours, only: [ :edit, :update ]
    resources :testimonials, except: [ :show ]
    resources :reservations, only: [ :index, :update, :destroy ]
    resources :orders, only: [ :index, :update, :destroy ]
    resources :meal_deals, except: [ :show ]
    resource :site_settings, only: [ :edit, :update ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
