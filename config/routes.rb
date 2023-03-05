Rails.application.routes.draw do
  resources :tweets

  get 'pages/home'

  root 'pages#home'

  get 'dashboard/index', as: 'dashboard'

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :usernames, only: %i[new update]
end
