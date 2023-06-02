class Retweet < ApplicationRecord
  has_noticed_notifications
  after_create_commit :notify_recipient

  belongs_to :user
  belongs_to :tweet, counter_cache: :retweets_count

  validates :user_id, uniqueness: { scope: :tweet_id }

  private

  def notify_recipient
    # Don't create notifications if you are creating it for your own tweet
    return if tweet.user == user

    RetweetNotification.with(message: self).deliver(tweet.user)
  end
end
