class LikeNotification < Noticed::Base
  deliver_by :database

  def like
    # params[:message]
    message_json = JSON.parse(params)['message']
    GlobalID::Locator.locate(message_json['_aj_globalid'])
  end

  def creator
    like.user
  end

  def tweet
    like.tweet
  end

  def type
    'Like'
  end

  def message
    t('.message')
  end
end
