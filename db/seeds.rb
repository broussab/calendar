# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  User.create!(
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    slackhandle: Faker::Internet.user_name,
    email:  Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end
users = User.all

10.times do
  Meeting.create!(
    user: users.sample,
    name: Faker::Name.name,
    reason: Faker::Hipster.word,
    start_time: Faker::Time.between(DateTime.now - 30, DateTime.now + 10),
    end_time: Faker::Time.between(DateTime.now + 10, DateTime.now + 40)
  )
end

User.create!(
  firstname: 'Alyssa',
  lastname: 'Broussard',
  slackhandle: 'Alyssa',
  email:  'alyssabroussard@legalshieldcorp.com',
  password: 'password',
  password_confirmation: 'password',
  role: 'admin'
)

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Meeting.count} events created"
