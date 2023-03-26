class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @all_tweets = Tweet.includes(:liked_users, :retweeted_users, :user).order(created_at: :desc)
    redirect_to dashboard_path
  end

  def show
    @full_tweet = @tweet
  end

  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to dashboard_path, notice: 'Tweet was successfully created.' }
        format.turbo_stream # This line calls the create.turbo_stream.erb file
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body, :user_id)
  end
end
