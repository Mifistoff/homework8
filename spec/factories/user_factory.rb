FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user.#{n}@example.com" }
    password         Faker::Internet.password(20)
  end
end
