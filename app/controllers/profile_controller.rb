class ProfileController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
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
