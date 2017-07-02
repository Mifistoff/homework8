FactoryGirl.define do
  factory :task do
    body { Faker::Hipster.word }
  end
end
