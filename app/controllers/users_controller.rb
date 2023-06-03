class UsersController < ApplicationController
  before_action :authenticate_user!

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers
  end

  def followings
    @user = User.find(params[:user_id])
    @followings = @user.following_users
  end

  def show
    redirect_to profile_path if params[:id].to_i == current_user.id
    @user = User.find(params[:id])
    @user_tweets = @user.tweets.includes(:liked_users,
                                         :retweeted_users).where(parent_tweet_id: nil) | @user.retweeted_tweets
  end
end
