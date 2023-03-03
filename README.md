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
