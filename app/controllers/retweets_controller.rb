class RetweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @retweet = current_user.retweets.create(tweet: @tweet)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @retweet = @tweet.retweets.find(params[:id])
    Notification.find_by(params: { message: @retweet })&.delete
    @retweet.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def set_tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end
