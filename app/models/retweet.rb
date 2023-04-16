class Retweet < ApplicationRecord
  # For Notifications
  include PublicActivity::Common
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  belongs_to :user
  belongs_to :tweet, counter_cache: :retweets_count

  validates :user_id, uniqueness: { scope: :tweet_id }
end
