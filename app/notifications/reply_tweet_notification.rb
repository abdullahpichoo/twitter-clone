class ReplyTweetNotification < Noticed::Base
  deliver_by :database

  def reply_tweet
    message_json = JSON.parse(params)['message']
    GlobalID::Locator.locate(message_json['_aj_globalid'])
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
