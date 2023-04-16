# frozen_string_literal: true

Rails.application.routes.draw do
  # root route
  root 'landing_page#index'

  # landing page controller routes
  get 'landing_page/index', to: 'landing_page#index', as: 'home_page'

  # session controller actions: login and signout
  get 'user/login', to: 'sessions#new', as: 'user_login'
  post 'sessions/create', to: 'sessions#create', as: 'sessions'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'user_signout'

  get '/index', to: 'application#index'

  # USERS CONTROLLER ROUTES
  ## all users
  get '/users', to: 'users#index', as: 'all_users'
  ## user signup form
  get '/user/signup', to: 'users#new', as: 'new_user'
  ## user submit signup form
  post '/user/signup', to: 'users#create'
  ## user profile
  get 'user/:id/profile', to: 'users#show', as: 'user_profile'

  # TASKS CONTROLLER ROUTES
  ## all tasks
  get 'user/tasks', to: 'tasks#index', as: 'user_tasks'

  get 'user/tasks/feed', to: 'tasks#feed', as: 'user_tasks_feed'
  # task signup form
  get 'user/tasks/new', to: 'tasks#new', as: 'new_task'
  ## task submit signup form
  post 'user/tasks/new', to: 'tasks#create', as: 'create_task'
  # task profile
  get 'users/tasks/:task_id', to: 'tasks#show', as: 'user_task'
  # complete task
  post 'user/tasks/complete', to: 'tasks#complete_task', as: 'complete_task'
  # delete task
  delete 'user/:id/tasks/:task_id/delete', to: 'tasks#destroy', as: 'delete_task'

  # FRIENDS CONTROLLER ROUTES
  ## all friends
  get 'user/friends', to: 'friends#index', as: 'all_friends'
  ## send friend request
  post 'user/friends/add', to: 'friends#create', as: 'add_friend'
  ## accept friend request
  patch 'user/friends/accept', to: 'friends#accept_friend_request', as: 'accept_friend_request'
  ## reject friend request
  patch 'user/friends/reject', to: 'friends#reject_friend_request', as: 'reject_friend_request'
end
