require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:user_b) { create(:user) }

  before { sign_in user }

  describe 'GET /show' do
    context 'user is the signed in user' do
      it 'redirects to profile page' do
        get user_path(user)
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'user is not the signed in user' do
      it 'returns http success' do
        get user_path(user_b)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
