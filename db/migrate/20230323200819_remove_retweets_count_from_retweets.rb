class RemoveRetweetsCountFromRetweets < ActiveRecord::Migration[7.0]
  def change
    remove_column :retweets, :retweets_count, :integer
  end
end
