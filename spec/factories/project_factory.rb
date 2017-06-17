FactoryGirl.define do
  factory :project do
    name { Faker::Hipster.word }
  end
end
