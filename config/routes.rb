Rails.application.routes.draw do
  resources :tweets

  get 'pages/home'

  root 'pages#home'

  get 'dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :usernames, only: %i[new update]
end
