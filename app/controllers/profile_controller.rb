class ProfileController < ApplicationController
  before_action :authenticate_user!
  def show; end

  def update
    current_user.update(user_params)
    # redirect_to profile_path
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.turbo_stream
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :display_name, :profile_picture)
  end
end
