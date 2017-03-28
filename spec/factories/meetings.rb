FactoryGirl.define do
  factory :meeting do
    name { Faker::Name.name }
    reason { Faker::Hipster.word }
    start_time { Faker::Time.between(DateTime.now - 30, DateTime.now + 10) }
    end_time { Faker::Time.between(DateTime.now + 10, DateTime.now + 40) }
    user
  end
end
