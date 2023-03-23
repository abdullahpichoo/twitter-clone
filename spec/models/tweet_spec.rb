require 'rails_helper'

RSpec.describe Tweet, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:user) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes).source(:user) }

  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_users).through(:retweets).source(:user) }

  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }
end
