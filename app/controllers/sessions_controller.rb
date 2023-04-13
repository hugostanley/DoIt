class SessionsController < ApplicationController
  before_action :check_if_logged_in, only: [:create, :new]
  def new; end

  def create
    @user = find_and_authenticate_user(params[:email], params[:password])
    if @user
      session[:is_logged_in] = true
      session[:user_id] = @user.id
      p session
      redirect_to user_tasks_path @user
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to user_login_path
    end
  end

  def destroy
    p "this is running"
    session[:user_id] = nil
    session[:is_logged_in] = nil
    redirect_to home_page_path
  end

  private

  def find_and_authenticate_user(user_email, password)
    user = User.find_by(email: user_email)
    user if user&.auth_with_password_digest(password)
  end

  def check_if_logged_in
    is_logged_in = session[:user_id].present?
    redirect_to user_tasks_path session[:user_id] if is_logged_in && User.find(session[:user_id])
  end
end
