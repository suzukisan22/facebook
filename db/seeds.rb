# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |n|
  email = Faker::Internet.email
  uid = Faker::Code.ean
  password = "password"
  name = Faker::Internet.user_name
  User.create!(
  email: email,
  password: password,
  password_confirmation: password,
  name: name,
  uid: uid
  )
end

10.times do |n|
  title = Faker::Book.title
  content = Faker::Hacker.say_something_smart
  user_id = n
  Topic.create!(title: title,
               content: content,
               user_id: user_id
               )
end

10.times do |n|
  content = Faker::Hacker.say_something_smart
  user_id = n
  topic_id = n
  Comment.create!(
               user_id: user_id,
               topic_id: topic_id,
               content: content
               )
end
