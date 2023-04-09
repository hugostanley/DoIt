# frozen_string_literal: true
class UsersController < ApplicationController
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


end
