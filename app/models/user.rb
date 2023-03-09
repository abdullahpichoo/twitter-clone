class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Sets the Display Name of the User as the Capitalized version of the username
  private

  before_save :set_display_name, if: -> { username.present? && display_name.blank? }

  def set_display_name
    self.display_name = username.humanize
  end
end
