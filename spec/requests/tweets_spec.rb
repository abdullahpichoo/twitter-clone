require 'rails_helper'

RSpec.describe '/tweets', type: :request do
  let(:valid_attributes) do
    { body: 'this is a tweet' }
  end

  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

  describe 'GET /show' do
    it 'successfully shows the tweet page' do
      get tweet_path(tweet)
      expect(response).to have_http_status(:success)
    end

    it 'increases the View Count if the tweet has not been viewed' do
      expect { get tweet_path(tweet) }.to change { View.count }.by(1)
    end

    it 'does not increase the View Count if the tweet has already been viewed' do
      create(:view, user:, tweet:)
      expect { get tweet_path(tweet) }.not_to change { View.count }
    end
  end

  describe 'POST /create' do
    context 'when user signed out' do
      it 'redirects to sign in' do
        post tweets_path, params: { tweet: valid_attributes }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when user signed in' do
      it 'successfully posts the tweet' do
        user = create(:user)
        sign_in user
        expect do
          post tweets_path, params: { tweet: valid_attributes }
        end.to change { Tweet.count }.by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
