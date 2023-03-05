class ApplicationController < ActionController::Base
  before_action :set_up_username

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
