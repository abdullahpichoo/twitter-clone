Rails.application.routes.draw do
  resources :tweets do
    resources :likes, only: %i[create destroy]
    resources :retweets, only: %i[create destroy]
  end

  get 'pages/home'

  root 'dashborad#index'

  get 'dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :usernames, only: %i[new update]
end
