Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post "/sessions", to: "sessions#create"
  get "/sessions/queue", to: "sessions#queue"
  get "/sessions/:id", to: "sessions#show", as: "session"
end
