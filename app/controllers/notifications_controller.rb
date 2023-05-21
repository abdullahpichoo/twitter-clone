class NotificationsController < ApplicationController
  before_action :authenticate_user!
  require 'benchmark'

  def index
    # Query all the public activities except the activities of the current user

    @notifications = PublicActivity::Activity.all
                                             .includes(:trackable, :owner)
                                             .where.not(owner_id: current_user.id)
                                             .order(created_at: :desc)

    # Marking all notifications as read
    @notifications.each do |n|
      n.parameters[:unread] = false
      n.save
    end
    @unread_notifications = false

    # Filtering the notifications so that only the notifications that are relevant to the current user are shown
    @notifications = @notifications.select do |notification|
      case notification.key
      when 'like.create'
        notification.trackable.tweet.user == current_user
      when 'tweet.create'
        current_user.following_users.include?(notification.trackable.user)
      when 'follow.create'
        true
      when 'retweet.create'
        notification.trackable.tweet.user == current_user
      when 'reply_tweet.create'
        notification.trackable.parent_tweet.user == current_user
      else
        false
      end
    end
  end
end
