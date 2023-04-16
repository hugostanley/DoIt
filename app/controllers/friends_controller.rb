# frozen_string_literal: true

# FriendsController
# Controller for the friendship model
class FriendsController < ApplicationController
  def index
    @pending_friends = User.get_friends_by_status session[:user_id], 'pending'
    @accepted_friends = User.get_friends_by_status session[:user_id], 'accepted'
    @rejected_friends = User.get_friends_by_status session[:user_id], 'rejected'
    @requested_friends = User.get_friends_by_status session[:user_id], 'requested'
  end

  def new
    @friend = Friendship.new
  end

  def create
    @user_1_friendship = Friendship.find_or_initialize_by(friend_request_params)
    @user_2_friendship = Friendship.find_or_initialize_by(user_id: friend_request_params[:friend_id], friend_id: friend_request_params[:user_id])
    @user_1_friendship.status = 'requested'
    @user_2_friendship.status = 'pending'

    if @user_1_friendship.save && @user_2_friendship.save
      redirect_to all_friends_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept_friend_request
    @user_1_friendship = Friendship.find_by(friend_request_params)
    @user_2_friendship = Friendship.find_by(user_id: friend_request_params[:friend_id])

    return unless @user_1_friendship.update(status: 'accepted') && @user_2_friendship.update(status: 'accepted')

    redirect_to all_friends_path
  end

  def reject_friend_request
    @user_1_friendship = Friendship.find_by(friend_request_params)
    @user_2_friendship = Friendship.find_by(user_id: friend_request_params[:friend_id], friend_id: friend_request_params[:user_id])

    return unless @user_1_friendship.update(status: 'rejected') && @user_2_friendship.update(status: 'rejected')

    redirect_to all_friends_path
  end

  private

  def private_friendship_params
    params.permit(:user_id, :friend_id, :status)
  end

  def friend_request_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
