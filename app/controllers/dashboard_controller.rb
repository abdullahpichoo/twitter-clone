class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_tweets = Tweet.includes(:liked_users, :retweeted_users, :user).order(created_at: :desc)
    # redirect_to tweets_path
  end
end
