require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe 'Setting Display Names' do
    context 'When Display Name is already set' do
      it 'should update the display name' do
        user = build(:user, username: 'test', display_name: 'Test Display Name')
        user.save
        user.update(display_name: 'Changed Display Name')
        expect(user.reload.display_name).to eq('Changed Display Name')
      end
    end
    context 'When Display Name is not set and the user has just been created' do
      it 'should humanize the username to display name' do
        user = build(:user, username: 'helloworld')
        user.save

        expect(user.reload.display_name).to eq('Helloworld')
      end
    end
  end
end
