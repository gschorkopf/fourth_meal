require 'sidekiq/web'
require 'admin_constraint'

Foodfight::Application.routes.draw do
  get "dashboard" => "dashboard#index", :as => 'dashboard'
  resources :categories

  root :to => "restaurants#index"

  resources :orders do
    post 'purchase', :on => :member
    get 'confirmation', :on => :member
  end

  resources :order_items

  post "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get "sign_up" => "users#new"

  resources :users
  resources :sessions
  get "/code" => redirect("https://github.com/JonahMoses/dinner_dash")
  resources :item_categories
  resources :items

  resources :restaurants

  mount Sidekiq::Web, at: '/sidekiq', :constraints => AdminConstraint.new

end
