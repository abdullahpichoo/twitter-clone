Rails.application.routes.draw do
  get 'profile/show'
  resources :tweets, only: %i[index show create] do
    resources :likes, only: %i[create destroy]
    resources :retweets, only: %i[create destroy]
    resources :reply_tweets, only: %i[create]
  end

  get 'pages/home'

  root 'pages#home'

  get 'dashboard', to: 'dashboard#index'
  get 'profile', to: 'profile#show'
  put 'profile', to: 'profile#update'

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  resources :usernames, only: %i[new update]
end
