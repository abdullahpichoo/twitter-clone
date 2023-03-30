class Following < ApplicationRecord
  belongs_to :user
  # :following_user -> User they follow
  belongs_to :following_user, class_name: "User"
end
