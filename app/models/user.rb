class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_one_attached :profile_picture
  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :set_display_name, if: -> { username.present? && display_name.blank? }

  # Sets the Display Name of the User as the Capitalized version of the username
  def set_display_name
    self.display_name = username.humanize
  end

  # Renders a downsized variant of the profile picture
  def profile_thumbnail
    return unless profile_picture.attached?

    profile_picture.variant(resize_to_fill: [100, 100], format: :jpeg,
                            saver: { subsample_mode: 'on', strip: true, interlace: true, quality: 80 }).processed
  end

  # saver: { subsample_mode: "on", strip: true, interlace: true, quality: 80 }: This option specifies the settings for the JPEG encoder. subsample_mode: "on" enables chroma subsampling, which reduces file size without significantly affecting image quality. strip: true removes any metadata from the image file. interlace: true enables progressive rendering, which loads a low-resolution version of the image first and then gradually improves the quality. quality: 80 sets the JPEG compression quality to 80 out of 100.
end
