require 'rails_helper'

RSpec.describe 'Followings', type: :request do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  before { sign_in user_a }

  describe 'POST /create' do
    it 'creates a new following for user_a' do
      expect do
        post user_followings_path(user_a), params: {
          following_user_id: user_b.id
        }
      end.to change { Following.count }.by(1)
      expect(response).to redirect_to user_path(user_b)
    end
  end

  describe 'DELETE /destroy' do
    it 'removes the following' do
      following = create(:following, user: user_a, following_user: user_b)
      expect do
        delete user_following_path(user_a, following)
      end.to change { Following.count }.by(-1)
      expect(response).to redirect_to user_path(user_b)
    end
  end
end
