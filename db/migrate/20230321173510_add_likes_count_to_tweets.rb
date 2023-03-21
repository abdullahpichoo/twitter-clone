class AddLikesCountToTweets < ActiveRecord::Migration[7.0]
  def up
    add_column :tweets, :likes_count, :integer, null: false, default: 0

    Tweet.find_each do |t|
      t.update!(likes_count: t.likes.size)
    end
  end

  def down
    remove_column :tweets, :likes_count
  end
end
