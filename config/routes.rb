Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :reviews, only: [:create]
  resources :friendships, only: [:index, :create]
  patch 'friendships', to: 'friendships#update', as: 'accept_friend'
  delete 'friendships', to: 'friendships#destroy', as: 'delete_friend'

  # Defines the root path route ("/")
  # root "articles#index"
end
