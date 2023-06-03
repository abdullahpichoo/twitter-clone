require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  # Create followers
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }

  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  let(:valid_attributes) do
    { body: 'this is a tweet' }
  end

  before { sign_in user }

  # Integration Test for testing notifications
  describe 'Has Tweeted Notifications to all Followers' do
    context 'when user signed in and posts a tweet' do
      it 'sends notifications to all its followers' do
        # Create Follows
        post user_followings_path(user), params: {
          following_user_id: user_a.id
        }
        post user_followings_path(user), params: {
          following_user_id: user_b.id
        }
        # Create tweet
        expect do
          post tweets_path, params: { tweet: valid_attributes }
        end.to change { Notification.count }.by(user.followers.count)
      end
    end
  end
end
