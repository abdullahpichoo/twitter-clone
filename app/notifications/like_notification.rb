class LikeNotification < Noticed::Base
  deliver_by :database

  def like
    params[:message]
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
