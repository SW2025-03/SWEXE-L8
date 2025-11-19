Rails.application.routes.draw do
  get "sessions/new"
  root 'events#index'

  resources :users
  resources :events do
    resources :participations
    get 'export_csv', on: :collection
  end

  resource :session
end
