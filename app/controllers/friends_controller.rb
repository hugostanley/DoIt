class FriendsController < ApplicationController

  def index
    @pending_friends = User.all_pending_friends session[:user_id]
    @accepted_friends = User.all_accepted_friends session[:user_id]
  end

  def new
    @friend = Friendship.new
  end

  def create
    @user_1_friendship = Friendship.new(private_friendship_params)
    @user_2_friendship = Friendship.new(user_id: private_friendship_params[:friend_id], friend_id: private_friendship_params[:user_id], status: private_friendship_params[:status])

    if @user_1_friendship.save && @user_2_friendship.save
      redirect_to all_friends_path session[:user_id]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept_friend_request
    @user_1_friendship = Friendship.find(user_id: session[:user_id])
  end

  private

  def private_friendship_params
    params.permit(:user_id, :friend_id, :status)
  end
end
