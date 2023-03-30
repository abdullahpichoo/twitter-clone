require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { create(:user) }
  before { sign_in user }
  describe 'GET /show' do
    it 'returns http success' do
      get profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    it 'successfully updates the display name' do
      expect do
        put profile_path, params: {
          user: {
            display_name: 'Test'
          }
        }
      end.to change { user.reload.display_name }.to('Test')
      expect(response).to redirect_to(profile_path)
    end

    it 'successfully updates the username' do
      expect do
        put profile_path, params: {
          user: {
            username: 'ttest'
          }
        }
      end.to change { user.reload.username }.to('ttest')
      expect(response).to redirect_to(profile_path)
    end
  end
end
