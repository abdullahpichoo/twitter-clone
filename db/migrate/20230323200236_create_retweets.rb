class CreateRetweets < ActiveRecord::Migration[7.0]
  def change
    create_table :retweets do |t|
      t.integer :retweets_count
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
