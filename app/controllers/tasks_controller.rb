# frozen_string_literal: true

# TasksController
# the TODO controller
class TasksController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(session[:user_id])
    @tasks = Task.sort_tasks_by_latest_update(@user.id)
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:task_id])
  end

  def create
    curr_user = User.find(session[:user_id])
    @task = Task.new(secure_new_task_params)
    @task[:user_id] = session[:user_id]
    @new_task = {username: curr_user.id, email: curr_user.email, task: @task}

    respond_to do |format|
      if @task.save
        format.html { render user_tasks_path }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def complete_task
    @user = User.find(session[:user_id])
    @tasks = Task.where(user_id: @user.id)
    task = Task.find(params[:task_id])

    return unless task.present?

    task.update!(date_completed: Time.now, is_completed: true)
    if request.referrer == user_tasks_url
      redirect_to user_tasks_path
    else
      redirect_to user_task id: session[:user_id], task_id: task.id
    end
  end

  def destroy
    task = Task.find(params[:task_id])
    task.destroy
    redirect_to user_tasks_path
  end

  def feed
    @tasks = Task.tasks_for_feed(User.find(session[:user_id]))
  end

  def add(_what_is, _you)
    "neat"
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
    flash[:error] = "Please Log in with your account first"
    redirect_to user_login_path
  end
end
