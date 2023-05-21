class ReplyTweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @reply_tweet = @tweet.reply_tweets.create(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @reply_tweet.save
        @reply_tweet.create_activity key: 'reply_tweet.create', owner: current_user,
                                     parameters: { recipient_id: @tweet.user.id, parent_tweet_id: @tweet.id, tweet_id: @reply_tweet.id, unread: true }
        format.html { redirect_to dashboard_path }
        format.turbo_stream # This line calls the create.turbo_stream.erb file
      end
    end
  end

  private

  def set_tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
