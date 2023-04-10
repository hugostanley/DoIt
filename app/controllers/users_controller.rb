# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :require_login 
  before_action :private_profile, only: [:show] 
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(secure_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def secure_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_login
    is_logged_in = session[:is_logged_in]

    if is_logged_in && User.find(session[:user_id])
      p "user is logged in"
    else 
      redirect_to user_login_path
    end
  end

  def private_profile
    unless session[:user_id] && session[:user_id] == params[:id].to_i
      flash[:error] = "login first"
      redirect_to user_login_path
    end
  end
end
