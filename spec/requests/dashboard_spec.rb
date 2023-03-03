require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  describe 'GET /dashboard' do
    context 'when not signed in' do
      it 'returns a page redirect' do
        get dashboard_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when signed in' do
      it 'is successful' do
        # These are Devise Helper Methods that are used in Testing to create and sign in users.
        # In order to set up these, follow the Readme.md
        user = create(:user)
        sign_in user

        get dashboard_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
