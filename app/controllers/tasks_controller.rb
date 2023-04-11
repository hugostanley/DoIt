class TasksController < ApplicationController
  before_action :require_login
  def index
    @user = User.find(session[:user_id])
    @tasks = Task.where(user_id: @user[:id])
  end

  def new
    @task = Task.new
    p @user
  end

  def show
    @task = Task.find(params[:task_id])
  end

  def create
    @task = Task.new(secure_new_task_params)
    @task[:user_id] = session[:user_id]

    if @task.save
      redirect_to user_task_path(id: session[:user_id], task_id: @task[:id]) 
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private

  def secure_new_task_params
    params.require(:task).permit(:title, :description, :deadline)
  end

  def require_login
    is_logged_in = session[:is_logged_in]

    # Guard clause to return early if user is logged in
    return if is_logged_in && User.find(session[:user_id])

    # else go to login page
    flash[:error] = 'Please Log in with your account first'
    redirect_to user_login_path
  end
end
