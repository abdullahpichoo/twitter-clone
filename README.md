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

### Fix

Introduce a new column 'Likes_count' in the tweet model and do counter caching.
Counter Cache removes the need for querying the likes count every time a tweet is listed, Rails manages it itself and the likes count is stored in the database regardless.

### Problem (24-3-2023)

When querying all the tweets it hits the databases as many times as there are tweets which is very inefficient

### Fix

There's something called eager loading. In eager loading, Rails will preload the content of the database along with their associations and joins and this is will result in significantly less hits to the database
