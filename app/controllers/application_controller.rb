class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  before_action :set_up_username
  before_action :set_all_users

  def set_all_users
    @all_users ||= User.all.where.not(id: current_user.id)
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
