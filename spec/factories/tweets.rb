FactoryBot.define do
  factory :tweet do
    body { 'MyString' }
    user
  end
end
