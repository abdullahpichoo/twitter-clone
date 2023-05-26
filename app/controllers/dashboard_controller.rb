class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = current_user.following_users.pluck(:id)
    # This line eager loads all the tweets of the following_users tweets.
    # This does not show reply tweets as they are not shown on the twitter homepage.
    @all_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                 user: :profile_picture_blob).where(user_id: followings).where(parent_tweet_id: nil).order(created_at: :desc)
  end
end
