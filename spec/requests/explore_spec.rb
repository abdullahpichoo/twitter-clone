require 'rails_helper'

RSpec.describe 'Explores', type: :request do
  describe 'GET /index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'returns http success' do
        get explore_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get explore_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
