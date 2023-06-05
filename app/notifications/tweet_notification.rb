class TweetNotification < Noticed::Base
  deliver_by :database

  def tweet
    message_json = JSON.parse(params)['message']
    GlobalID::Locator.locate(message_json['_aj_globalid'])
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
