module NotificationsHelper
  # Returns the Time Difference of when tweet was posted by now
  def created_at(tweet)
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime('%b %-d')
    else
      time_ago_in_words(tweet.created_at)
    end
  end
end
