class ExploreController < ApplicationController
  before_action :authenticate_user!
  before_action :clear_filter

  # get latest tweets from 3 random users
  def index
    users = User.all.sample(5).pluck(:id)
    @explore_tweets = Tweet.includes(:liked_users, :retweeted_users,
                                     user: :profile_picture_blob).where(user_id: users).where(parent_tweet_id: nil).order(created_at: :desc)

    @people = User.all.includes(:profile_picture_blob).where.not(id: current_user.id).order(created_at: :desc)

    # Seach for users whose username matches the filter or display name matches the filter
    return unless params[:filter].present?

    @search_users = User.all.includes(:profile_picture_blob).where('LOWER(username) LIKE ? OR LOWER(display_name) LIKE ?',
                                                                   "%#{params[:filter].downcase}%", "%#{params[:filter].downcase}%")
                        .where.not(id: current_user.id).sample(2)
  end

  private

  # Here I clear the filter if the explore page is visited by clicking the back from some other page.
  # This is done to avoid the filter being applied to the explore page when the user clicks back from
  # some other page.
  # The filter persists if the explore page is reloaded
  def clear_filter
    referrer_url = URI(request.referrer).path if request.referrer.present?
    return unless referrer_url != '/explore'

    params[:filter] = nil
  end
end
