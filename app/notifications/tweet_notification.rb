class TweetNotification < Noticed::Base
  deliver_by :database

  def tweet
    params[:message]
  end

  def creator
    tweet.user
  end

  def type
    'Tweet'
  end

  def message
    t('.message')
  end
end
