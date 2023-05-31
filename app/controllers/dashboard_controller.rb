class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # If the user is not following anyone, then show the tweets of any 2 random users.
    if current_user.followings.count.zero?
      random_users = User.all.sample(2).pluck(:id)
      @all_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                   user: :profile_picture_blob).where(user_id: random_users).where(parent_tweet_id: nil).order(created_at: :desc)
    else
      followings = current_user.following_users.pluck(:id)
      # This does not show reply tweets as they are not shown on the twitter homepage.
      @all_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                   user: :profile_picture_blob).where(user_id: followings).where(parent_tweet_id: nil).order(created_at: :desc)
    end
  end
end
