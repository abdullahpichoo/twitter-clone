require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }

  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_tweets).through(:likes).source(:tweet) }

  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_tweets).through(:retweets).source(:tweet) }

  it { should have_many(:views) }
  it { should have_many(:viewed_tweets).through(:views).source(:tweet) }

  it { should have_many(:followings).dependent(:destroy) }
  it { should have_many(:following_users).through(:followings).source(:following_user) }
  it { should have_many(:reverse_followings).with_foreign_key(:following_user_id).class_name('Following') }
  it { should have_many(:followers).through(:reverse_followings).source(:user) }

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
