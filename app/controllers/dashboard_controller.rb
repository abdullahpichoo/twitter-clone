class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # redirect_to tweets_path
  end
end
