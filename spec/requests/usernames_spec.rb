require 'rails_helper'

RSpec.describe 'Usernames', type: :request do
  let(:user) { create(:user, username: nil) }
  before { sign_in user }

  describe 'GET new' do
    context 'when signed in' do
      it 'should be successful' do
        get new_username_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PUT update' do
    context 'valid username' do
      it 'updates the username' do
        expect do
          put username_path(user), params: {
            user: {
              username: 'changed_username'
            }
          }
        end.to change { user.reload.username }.from(nil).to('changed_username')
        expect(user.reload.display_name).to eq(user.username.humanize)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'invalid username (empty username)' do
      it 'redirects back to new_username_path' do
        expect do
          put username_path(user), params: {
            user: {
              username: ''
            }
          }
        end.not_to change { user.reload.username }
        expect(response).to redirect_to(new_username_path)
      end
    end

    context 'invalid username (username with spaces)' do
      it 'redirects back to new_username_path' do
        expect do
          put username_path(user), params: {
            user: {
              username: 'invalid username'
            }
          }
        end.not_to change { user.reload.username }
        expect(response).to redirect_to(new_username_path)
      end
    end
  end
end
