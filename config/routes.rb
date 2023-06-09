Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resources :friendships, only: [:index, :create]
  patch 'friendships', to: 'friendships#update', as: 'accept_friend'
  delete 'friendships', to: 'friendships#destroy', as: 'delete_friend'
  post "/sessions", to: "sessions#create"
  get "/sessions/queue", to: "sessions#queue"
  get "/sessions/:id", to: "sessions#show", as: "sessions_show"
  delete "/sessions", to: "sessions#destroy", as: "sessions_destroy"
  delete "/sessions/destroy_sessions", to: "sessions#destroy_sessions"
  get "/sessions/:session_id/reviews/new", to: "reviews#new"
  post "/sessions/:session_id/reviews", to: "reviews#create", as: "new_review"
end
