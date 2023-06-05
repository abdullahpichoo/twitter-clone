class FollowNotification < Noticed::Base
  deliver_by :database

  def follow
    message_json = JSON.parse(params)['message']
    GlobalID::Locator.locate(message_json['_aj_globalid'])
  end

  def creator
    follow.user
  end

  def tweet
    nil
  end

  def type
    'Follow'
  end

  def message
    t('.message')
  end
end
