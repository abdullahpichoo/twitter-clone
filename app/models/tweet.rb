class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy

  has_many :views, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :retweeted_users, through: :retweets, source: :user
  has_many :viewed_users, through: :views, source: :user

  # This is a Self Association of Reply Tweets with Tweets
  belongs_to :parent_tweet, foreign_key: :parent_tweet_id, class_name: 'Tweet', optional: true,
                            counter_cache: :reply_tweets_count
  # inverse_of ka matlab ha I'm creating bi directional association between parent_tweet and reply_tweet
  # so that each time reply_tweet instance is created, it will have the reference to the parent_tweet model.
  has_many :reply_tweets, class_name: 'Tweet', foreign_key: :parent_tweet_id, inverse_of: :parent_tweet

  validates :body, presence: true, length: { maximum: 280 }
end
