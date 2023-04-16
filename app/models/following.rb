class Following < ApplicationRecord
  # For Notifications
  include PublicActivity::Common
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  belongs_to :user, counter_cache: :followings_count
  # :following_user -> User they follow
  belongs_to :following_user, class_name: 'User', counter_cache: :followers_count

  validates :user_id, uniqueness: { scope: :following_user_id }
end
