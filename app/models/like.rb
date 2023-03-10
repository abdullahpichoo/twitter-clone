class Like < ApplicationRecord
  # Like ID | User ID | Tweet ID
  # 1       | 2       | 32
  # This table indicates that there exists a Like Objects created by User 2, on a Tweet 32
  # If I do @tweet.likes -> It will return all the rows where Tweet ID == @tweet.id
  # These returned rows will also have User IDs that we can use
  # We can check the returned result for any User ID of your choice by doing this
  # @tweet.likes.include?(user.likes.find_by(tweet: @tweet)) 

  belongs_to :tweet
  belongs_to :user

  validates :user_id, uniqueness: { scope: :tweet_id }
end
