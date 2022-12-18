FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'test1111' }
    confirmed_at { Date.today }
  end
end
