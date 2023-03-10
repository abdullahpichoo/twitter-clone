Rails.application.routes.draw do
  # get 'likes/create'
  # get 'likes/destroy'

  resources :tweets do
    resources :likes, only: %i[create destroy]
  end

  get 'pages/home'

  root 'pages#home'

  get 'dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :usernames, only: %i[new update]
end
