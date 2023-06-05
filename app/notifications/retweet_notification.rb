
class RetweetNotification < Noticed::Base
  deliver_by :database

  def retweet
    message_json = JSON.parse(params)['message']
    GlobalID::Locator.locate(message_json['_aj_globalid'])
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
