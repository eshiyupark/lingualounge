Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: "pages#home"
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
  post "/sessions/:session_id/reviews", to: "reviews#create", as: "new_review"
  patch '/user_languages/update', to: "user_languages#update_language", as: "update_language"
  get "/user_languages/new", to: "user_languages#new_language", as: 'new_language'
  post "/user_languages/setup", to: "user_languages#setup_language"
  post "/user_languages", to: "user_languages#create_language", as: 'add_user_language'
  delete '/user_languages/:id', to: 'user_languages#destroy_language', as: 'delete_language'
  get '/user_languages/edit', to: 'user_languages#edit_language', as: 'edit_language'
end
