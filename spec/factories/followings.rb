FactoryBot.define do
  factory :following do
    user
    following_user do
      user
    end
  end
end
