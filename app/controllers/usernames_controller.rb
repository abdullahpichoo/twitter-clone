class UsernamesController < ApplicationController
  before_action :authenticate_user!
  # This skip_before_action saves me from too many redirects problem, rn I don't exactly know how it works
  skip_before_action :set_up_username

  def new; end

  def update
    return unless current_user.update(username_params)

    redirect_to dashboard_path, notice: 'Username was successfully updated!'
  end

  private

  def username_params
    params.require(:user).permit(:username)
  end


end
