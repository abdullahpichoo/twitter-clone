class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = current_user.following_users.pluck(:id)
    @all_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                 :user).where(user_id: followings).where(parent_tweet_id: nil).order(created_at: :desc)
    # redirect_to tweets_path
  end
end
