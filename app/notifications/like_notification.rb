class LikeNotification < Noticed::Base
  deliver_by :database

  def like
    # params[:message]
    # If params[:message] throws no error then return params[:message]
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
