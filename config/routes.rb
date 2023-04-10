Rails.application.routes.draw do
  get 'user/login', to: "sessions#new", as: "user_login"
  post 'sessions/create', to: "sessions#create", as: "sessions" 
  delete 'sessions/destroy', to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get "/index", to: "application#index"

  # all users
  get "/users", to: "users#index", as: "all_users"

  # user signup form
  get "/user/signup", to: "users#new", as: "new_user"

  # user post request signup
  post "/user/signup", to: "users#create"

  # user profile
  get "users/profile/:id", to: "users#show", as: "user"
end
