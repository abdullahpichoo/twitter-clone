class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @like = current_user.likes.create(tweet: @tweet)
    # Don't create notification for self-likes
    if @tweet.user != current_user
      @like.create_activity(key: 'like.create', owner: current_user,
                            parameters: { unread: true, recipient_id: @like.tweet.user.id, tweet_id: @tweet.id })
    end
    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @like = @tweet.likes.find(params[:id])
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
