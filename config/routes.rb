Rails.application.routes.draw do
  resources :users
  resources :events
  resources :participations

  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  match  "logout", to: "sessions#destroy", via: [:delete, :get]

  root "events#index"
end
