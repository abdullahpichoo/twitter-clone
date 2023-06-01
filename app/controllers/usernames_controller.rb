class UsernamesController < ApplicationController
  before_action :authenticate_user!
  # This skip_before_action saves me from too many redirects problem, rn I don't exactly know how it works
  skip_before_action :set_up_username
  require 'image_processing/vips'

  def new; end

  def update
    if username_params[:username].present? && current_user.update(username_params)

      optimize_and_attach_profile_picture
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

  def optimize_and_attach_profile_picture
    return unless params[:user][:profile_picture].present?

    # Load the image using ImageProcessing gem
    image = ImageProcessing::Vips.source(params[:user][:profile_picture])

    # Optimize the image (e.g., resize, compress, etc.) using ImageProcessing methods
    optimized_image = image.resize_to_fill(300, 300)
                           .convert('jpeg')
                           .saver(subsample_mode: 'on', strip: true, interlace: true, quality: 90)
                           .call

    # # Generate a unique filename by concatenating the current time with the original filename
    current_time = Time.now.strftime('%Y%m%d%H%M%S')
    new_filename = "#{current_time}_#{current_user.username}_pfp"

    # Attach the optimized image to the user's profile picture attachment
    current_user.profile_picture.attach(io: optimized_image,
                                        filename: new_filename)
  end

  def username_params
    params.require(:user).permit(:username, :display_name, :profile_picture)
  end
end
