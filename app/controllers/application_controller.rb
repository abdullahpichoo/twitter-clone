class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  before_action :set_up_username
  before_action :set_all_users
  before_action :set_unread_notifications

  def set_all_users
    @all_users ||= User.all.includes(:profile_picture_blob).where.not(id: current_user&.id).sample(3)
  end

  def set_unread_notifications
    return unless user_signed_in?

    @unread_notifications_count ||= PublicActivity::Activity.all.where('parameters LIKE ? AND parameters LIKE ?',
                                                                       "%recipient_id: #{current_user.id}%", '%unread: true%').count
    @unread_notifications = @unread_notifications_count.positive?
  end

  protected

  # After Sign In, User gets redirected to the Dashboard that contains all the tweets
  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  # After Sign In if the username is Blank, Redirect to Set Up a username
  def set_up_username
    return unless user_signed_in? && current_user.username.blank?

    redirect_to new_username_path
  end
end
