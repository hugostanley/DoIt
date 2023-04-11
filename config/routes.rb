# frozen_string_literal: true

Rails.application.routes.draw do
  get 'landing_page/index', to: 'landing_page#index', as: 'home_page'
  get 'user/login', to: 'sessions#new', as: 'user_login'
  post 'sessions/create', to: 'sessions#create', as: 'sessions' 
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'user_signout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  root 'landing_page#index'

  get '/index', to: 'application#index'

  # all users
  get '/users', to: 'users#index', as: 'all_users'

  # user signup form
  get '/user/signup', to: 'users#new', as: 'new_user'

  # user post request signup
  post '/user/signup', to: 'users#create'

  # user profile
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'

  # tasks

  # all tasks
  get 'users/:id/tasks', to: 'tasks#index', as: 'user_tasks'
  # submit new task
  post 'users/:id/tasks', to: 'tasks#create'
  # new task form
  get 'users/:id/tasks/new', to: 'tasks#new', as: 'new_task'
  # show task
  get 'users/:id/tasks/:task_id', to: 'tasks#show', as: 'user_task'
end
