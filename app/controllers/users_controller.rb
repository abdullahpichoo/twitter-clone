class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    redirect_to profile_path if params[:id].to_i == current_user.id
    @user = User.find(params[:id])
    @user_tweets = @user.tweets.includes(:liked_users,
                                         :retweeted_users).where(parent_tweet_id: nil) | @user.retweeted_tweets
  end
end
