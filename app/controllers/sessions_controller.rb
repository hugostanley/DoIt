class SessionsController < ApplicationController
  before_action :check_if_logged_in
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    p user

    if user && user.auth_with_password_digest(params[:password])
      session[:is_logged_in] = true
      session[:user_id] = user.id
      p session
      redirect_to all_users_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end

  end

  def destroy
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def check_if_logged_in
    is_logged_in = session[:is_logged_in]
    redirect_to all_users_path if is_logged_in && User.find(session[:user_id])
  end
end
