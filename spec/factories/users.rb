FactoryGirl.define do
  pw = 'password'

  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    slackhandle { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password pw
    password_confirmation pw
    role :member
  end
end
