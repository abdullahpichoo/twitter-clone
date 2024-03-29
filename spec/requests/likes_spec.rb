require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

  describe 'POST /create' do
    it 'creates a new like' do
      expect do
        post tweet_likes_path(tweet)
      end.to change { Like.count && Notification.count }.by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'DELETE /destroy' do
    it 'removes a like' do
      like = create(:like, user:, tweet:)
      expect do
        delete tweet_like_path(tweet, like)
      end.to change { Like.count && Notification.count }.by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end

  # describe "GET /destroy" do
  #   it "returns http success" do
  #     get "/likes/destroy"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
