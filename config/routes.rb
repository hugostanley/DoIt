Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get "/index", to: "application#index"
  get "/users", to: "users#index", as: "all_users"
  get "/user/signup", to: "users#new", as: "new_user"
  post "/user/signup", to: "users#create"
  get "users/:id", to: "users#show", as: "user"
end
