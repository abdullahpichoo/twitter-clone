class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    followings = current_user.following_users.pluck(:id)
    # This line eager loads all the tweets of the following_users tweets.
    # This does not show reply tweets as they are not shown on the twitter homepage.
    @all_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                 :user).where(user_id: followings).where(parent_tweet_id: nil).order(created_at: :desc)
    redirect_to dashboard_path
  end

  def show
    create_view unless View.exists?(user: current_user, tweet: @tweet)

    @reply_tweets = @tweet.reply_tweets.includes(:liked_users, :retweeted_users, :user).order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))
    respond_to do |format|
      if @tweet.save
        @tweet.create_activity key: 'tweet.create', owner: current_user,
                               parameters: { unread: true, tweet_id: @tweet.id }
        format.html { redirect_to dashboard_path, notice: 'Tweet was successfully created.' }
        format.turbo_stream # This line calls the create.turbo_stream.erb file
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet ||= Tweet.find(params[:id])
  end

  def create_view
    View.create(tweet: @tweet, user: current_user)
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body, :user_id)
  end
end
