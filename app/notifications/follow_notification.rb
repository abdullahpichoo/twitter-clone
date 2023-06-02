class FollowNotification < Noticed::Base
  deliver_by :database

  def follow
    params[:message]
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
