require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # config/routes.rb

  root "application#about"

  get "about.json", to: "application#about"

  get "current_user", to: "users#show_current_user"
  get "users/reset_token", to: "users#reset_token"
  delete "signout", to: "users#signout"

  resources :reactions, only: [:index, :show]
  resources :actions, only: [:index, :show]
  resources :widgets

  devise_for :users, defaults: { format: :json },
                    controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions" }
  # devise_for :admin
  resources :users, only: [:index, :show, :update, :destroy]

  # Path for documentation
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
end
