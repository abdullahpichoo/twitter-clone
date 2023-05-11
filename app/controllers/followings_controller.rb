class FollowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :user

  def create
    set_sidebar_user
    following = user.followings.create(following_params)
    following.create_activity(key: 'follow.create', owner: current_user, parameters: { unread: true })
    @followed_by = following.following_user
    respond_to do |format|
      format.html { redirect_to user_path(following.following_user) }
      format.turbo_stream
    end
  end

  def destroy
    following = Following.find(params[:id])
    following.destroy

    respond_to do |format|
      format.html { redirect_to user_path(following.following_user) }
      format.turbo_stream
    end
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def set_sidebar_user
    @sidebar_user ||= User.find(params[:following_user_id])
  end

  def following_params
    params.permit(:user_id, :following_user_id)
  end
end
