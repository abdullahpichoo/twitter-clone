class ReplyTweetNotification < Noticed::Base
  deliver_by :database

  def reply_tweet
    if params.is_a?(Hash)
      # Access the attributes directly
      message = params[:message]
    else
      # Handle the case where params is not a Hash (e.g., JSON string)
      message_json = JSON.parse(params)['message']
      message = GlobalID::Locator.locate(message_json['_aj_globalid'])

    end
    message
  end

  def creator
    reply_tweet.user
  end

  def tweet
    reply_tweet
  end

  def type
    'ReplyTweet'
  end

  def message
    t('.message')
  end
end
