class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.newest_first
    return unless @unread_notifications

    current_user.notifications.mark_as_read!
  end
end
