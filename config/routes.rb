Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit]
  resources :friendships, only: [:index, :create]
  patch 'friendships', to: 'friendships#update', as: 'accept_friend'
  delete 'friendships', to: 'friendships#destroy', as: 'delete_friend'
  resources :friendships, only: :show do
    resources :messages, only: :create
  end
  post "/sessions", to: "sessions#create"
  get "/sessions/queue", to: "sessions#queue"
  get "/sessions/:id", to: "sessions#show", as: "sessions_show"
  delete "/sessions", to: "sessions#destroy", as: "sessions_destroy"
  delete "/sessions/destroy_sessions", to: "sessions#destroy_sessions"
  get "/sessions/:session_id/reviews/new", to: "reviews#new", as: "review_new"
  # make above route path something else
  post "/sessions/:session_id/reviews", to: "reviews#create", as: "new_review"
  patch '/user_languages/:id', to: "user_languages#update_language", as: "update_language"
  get "/user_languages/new", to: "user_languages#new_language", as: 'new_language'
  post "/user_languages", to: "user_languages#create_language", as: 'add_user_language'
  delete '/user_languages/:id', to: 'user_languages#destroy_language', as: 'delete_language'
end
