Rails.application.routes.draw do
  get "homepage/index"
  get "news/index"

  get "/login", to: "homepage#new"
  post "/login", to: "homepage#create"
  delete "/logout", to: "news#destroy"

  get "/signup", to: "register#new_user"
  post "/signup", to: "register#create"

  root "homepage#index"
end
