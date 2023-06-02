class Following < ApplicationRecord
  belongs_to :user, counter_cache: :followings_count
  # :following_user -> User they follow
  belongs_to :following_user, class_name: 'User', counter_cache: :followers_count

  has_noticed_notifications
  after_create_commit :notify_recipient

  validates :user_id, uniqueness: { scope: :following_user_id }

  private

  def notify_recipient
    FollowNotification.with(message: self).deliver(following_user)
  end
end
