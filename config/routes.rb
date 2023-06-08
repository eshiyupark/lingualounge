Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post "/sessions", to: "sessions#create"
  get "/sessions/queue", to: "sessions#queue"
  get "/sessions/:id", to: "sessions#show", as: "sessions_show"
  delete "/sessions", to: "sessions#destroy", as: "sessions_destroy"
end
