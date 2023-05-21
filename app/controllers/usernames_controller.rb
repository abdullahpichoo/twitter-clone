class UsernamesController < ApplicationController
  before_action :authenticate_user!
  # This skip_before_action saves me from too many redirects problem, rn I don't exactly know how it works
  skip_before_action :set_up_username

  def new; end

  def update
    if username_params[:username].present? && current_user.update(username_params)

      current_user.profile_picture.attach(params[:user][:profile_picture])
      current_user.optimize_profile_picture

      redirect_to dashboard_path, notice: 'Profile was successfully updated!'

    else
      flash[:alert] = if username_params[:username].blank?
                        'Username cannot be empty!'
                      else
                        current_user.errors.full_messages.join(', ')
                      end
      redirect_to new_username_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username, :display_name, :profile_picture)
  end
end
