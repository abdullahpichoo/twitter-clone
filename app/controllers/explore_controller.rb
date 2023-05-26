class ExploreController < ApplicationController
  before_action :authenticate_user!

  # get latest tweets from 3 random users
  def index
    users = User.all.sample(3).pluck(:id)
    @explore_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                     user: :profile_picture_blob).where(user_id: users).where(parent_tweet_id: nil).order(created_at: :desc)
    @people = User.all.includes(:profile_picture_blob).where.not(id: current_user.id)
  end
end
