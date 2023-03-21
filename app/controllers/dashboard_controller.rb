class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_tweets = Tweet.includes(:liked_users, :user).order(created_at: :desc)
  end
end
