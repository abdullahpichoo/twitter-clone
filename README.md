## Making a Twitter Clone on Ruby on Rails

# Commands to Set up Live Reload

- gems required: gem "guard-livereload" gem "rack-livereload"
- bundle exec guard init livereload
- bundle exec guard

# Using Rspec for Testing

- Used the Shoulda-Match gem that helps in writing one liner tests

# How to set up Devise Helper Methods that are used in the testing environment

FactoryBot is a gem that is the replacement for fixtures and provides easy syntax to access fixture objects

- Paste this line in the rails_helper.rb to access the devise helper methods:
  - config.include FactoryBot::Syntax::Methods
  - config.include Devise::Test::IntegrationHelpers, type: :request

# User Model:

    - Has Email and Password

# What am I working on right now?

### Problem (21-3-2023)

I added the like feature to the tweet model but the problem with it right now is that every time a tweet is listed, there are queries are need to be run which include joins and aggregations. Here what the problem is:
Joins:
'''<%= link_to tweet_like_path(tweet, tweet.likes.find_by(user: current_user)), data: {"turbo-method": "delete"}, class: "likes d-flex align-items-center gap-1 text-black text-decoration-none" do %>'''
Aggregation:
<%= tweet.likes.size %>

#### Fix

Introduce a new column 'Likes_count' in the tweet model and do counter caching.
Counter Cache removes the need for querying the likes count every time a tweet is listed, Rails manages it itself and the likes count is stored in the database regardless.

### Problem (24-3-2023)

When querying all the tweets it hits the databases as many times as there are tweets which is very inefficient

#### Fix

There's something called eager loading. In eager loading, Rails will preload the content of the database along with their associations and joins and this is will result in significantly less hits to the database

### Implementing Retweets same as the Likes

done. Making a retweet table with references to user and tweets
done. Adding a retweet_count as attribute
done. Writing associations in model
done. Writing model specs
done. Adding Routes
done. Writing controller
done. Adding methods in tweet_helper method
done. Updating the views
done. Writing request specs

### Building Tweet Show Page

Built the Tweet Show Page, ran into some problems. I can't really remember what were the problems but I fixed them somehow. Added the turbo functionality to the Tweet Show Page.

### View Count on Tweets

Same way I did the Likes and Retweet thing.

### Reply Tweet

This bit is interesting. Every Reply to a Tweet itself is a tweet and should be treated like so. So I'm adding a column """parent_tweet_id""" to the Tweet Table that will reference the ID of the Tweet that the reply belongs to. The """parent_tweet_id""" will have a ForeignKey Constraint which means that when a Tweet is created with a reference of parent_tweet_id, Rails will check the database and see if the parent_tweet_id that was passed is valid i.e. whether or not a Tweet with ID == parent_tweet_id exists in the database or not. If not, it will throw a ForeignKeyConstraintException.

In Active Record Validations, I'm using Self Association and bi directional associations.

### Following / Follower Associations

I started out with making a Followings table that will contain entries for each user that follows another user.
If user 1 follows user 3, then
| Following |
| user_id | following_user_id |
| 1 | 3 |

This means when a User follows another user, a new entry will be created in the Followings table, that will contain the ID of the user that initiated the follow as user_id and the user he started following as following_user_id.

##### User Table Associations

- has_many :followings, dependent: :destroy
  A user may have many users that he is following.

- has_many :following_users, through: :followings, source: :following_user
  A user may have many users that he is following. Using a Join Table here, we can query all the individual users that a user is following as user.following_users

- has_many :reverse_followings, foreign_key: :following_user_id, class_name: "Following"
  As I said above, when user 1 is following user 3, there exists a instance of following_user for user 1.
  In order to get the followers for user 3, we do reverse_followings association.
  This essentially means that user 3 will also have access to the instanes of the following_user but in reverse. User 3 will be able to query and see all the users that are following him. This is done using the foreign key.

- has_many :followers, through: :reverse_followings, source: :user
  This simply means that a user will have many followers through the reverse_followings table.

##### Notifications

I'm handling notifications using the public activity gem.
Type of notifications:

- Liked your tweet (just show tweet body)
- Replied to your tweet (unke reply ki body)
- Retweeted your tweet
- Started following you
- Liked your retweet (original tweet ki body)
