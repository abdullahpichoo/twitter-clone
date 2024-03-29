class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @like = current_user.likes.create(tweet: @tweet)
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @like = @tweet.likes.find(params[:id])
    Notification.find_by(params: { message: @like })&.delete
    @like.destroy

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
