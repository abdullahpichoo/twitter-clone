module TweetsHelper
  include Rails.application.routes.url_helpers

  # Returns the Time Difference of when tweet was posted by now
  def posted_at(tweet)
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime('%b %-d')
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  # For Liked Tweets ------------------------------------------
  # Returns the route path for liking a tweet (create,destroy)
  def get_tweet_like_path(current_user, tweet)
    if current_user_liked_this_tweet?(current_user, tweet)
      tweet_like_path(tweet, tweet.likes.find_by(user: current_user))
    else
      tweet_likes_path(tweet)
    end
  end

  # Returns whether html method is going to be POST or DELETE
  def get_liked_tweet_data_method(current_user, tweet)
    if current_user_liked_this_tweet?(current_user, tweet)
      'delete'
    else
      'post'
    end
  end

  # Returns SVG based on condition of tweet like
  def get_heart_type(current_user, tweet)
    if current_user_liked_this_tweet?(current_user, tweet)
      'bi bi-heart-fill'
    else
      'bi bi-heart'
    end
  end

  # Returns the color of the heart based on condition of tweet like
  def get_heart_style(current_user, tweet)
    if current_user_liked_this_tweet?(current_user, tweet)
      'color: #de5c9d'
    else
      ''
    end
  end
  # For Liked Tweets ------------------------------------------

  #--------------------------------------------------------------

  # For Retweeted Tweets --------------------------------------
  def get_tweet_retweet_path(current_user, tweet)
    if current_user_retweeted_this_tweet?(current_user, tweet)
      tweet_retweet_path(tweet, tweet.retweets.find_by(user: current_user))
    else
      tweet_retweets_path(tweet)
    end
  end

  # Returns whether html method is going to be POST or DELETE
  def get_retweeted_tweet_data_method(current_user, tweet)
    if current_user_retweeted_this_tweet?(current_user, tweet)
      'delete'
    else
      'post'
    end
  end

  # Returns the color of the heart based on condition of tweet like
  def get_retweet_icon_style(current_user, tweet)
    if current_user_retweeted_this_tweet?(current_user, tweet)
      'color: #198754'
    else
      ''
    end
  end
  # For Retweeted Tweets --------------------------------------

  # This function queries the tweets liked by the current user and checks if the passed tweet is on of them:
  # If true -> User has liked this tweet
  # If false -> User has NOT liked this tweet
  # This function uses memoization to save query processing every time a tweet is listed
  def current_user_liked_this_tweet(current_user, tweet)
    return unless tweet.likes_count.positive?

    @current_user_liked_this_tweet ||= tweet.liked_users.include?(current_user)
  end

  alias current_user_liked_this_tweet? current_user_liked_this_tweet

  # For Retweets -> Checking if the signed in user retweeted this
  def current_user_retweeted_this_tweet(current_user, tweet)
    return unless tweet.retweets_count.positive?

    @current_user_retweeted_this_tweet ||= tweet.retweeted_users.include?(current_user)
  end

  alias current_user_retweeted_this_tweet? current_user_retweeted_this_tweet
end
