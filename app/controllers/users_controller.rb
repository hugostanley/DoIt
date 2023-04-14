# frozen_string_literal: true

# Users Controller
# For:
# 1. creating a users account
# 2. showing a user profile
# 3. displaying all useres
# 4. handling authentication with sessions
class UsersController < ApplicationController
  # when users controller is ran, run the require_login method
  before_action :require_login, only: [:show, :index]

  # if a user is accessing someone elses account profile page '/users/profile/:id', run this private method
  before_action :private_profile, only: [:show]

  # Display all users
  # TODO: Admin authorization only
  def index
    current_user = User.find(session[:user_id])
    @users = User.where.not(id: session[:user_id]).reject {|user| current_user.friends.include?(user)}
  end

  # User profile
  def show
    @user = User.find(params[:id])
  end

  # Signup method, instantiates an empty user hash
  def new
    @user = User.new
  end

  # Post request to signup
  def create
    @user = User.new(secure_params)

    if @user.save
      session[:user_id]= @user.id
      session[:is_logged_in] = true
      redirect_to user_tasks_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Params validations
  def secure_params
    params.require(:user).permit(:username, :email, :password)
  end

  # First to run in this controller
  def require_login
    is_logged_in = session[:is_logged_in]

    # Guard clause to return early if user is logged in
    return if is_logged_in && User.find(session[:user_id])

    # else go to login page
    flash[:error] = 'Please Log in with your account first'
    redirect_to user_login_path
  end

  def private_profile
    # Guard clause to return early if user is accessing his/her own profile page
    return if session[:user_id] && session[:user_id] == params[:id].to_i

    # else error
    flash.now[:error] = 'This is not your account!'
    render inline: "<h1>You have no access to this account's profile</h1>"
    # redirect_to user_login_path
  end
end
