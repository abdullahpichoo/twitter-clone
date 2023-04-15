class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    followings = current_user.following_users.pluck(:id)
    @notifications = PublicActivity::Activity.all.where(owner_id: followings).order(created_at: :desc)
  end
end
