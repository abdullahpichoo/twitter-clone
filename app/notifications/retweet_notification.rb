
class RetweetNotification < Noticed::Base
  deliver_by :database

  def retweet
    params[:message]
  end

  def creator
    retweet.user
  end

  def tweet
    retweet.tweet
  end

  def type
    'Retweet'
  end

  def message
    t('.message')
  end
end
