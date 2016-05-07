# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "Test User",
            email: "example@testuser.de",
            password: "testpassword",
            password_confirmation: "testpassword",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@testuser.de"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content_type: 1,
                                         channel: 1,
                                         billing_type: 1,
                                         scope_hours: 20,
                                         title: title,
                                         remarks: title,
                                         scope_of_experience: title,
                                         scope_of_work: title,
                                         start_date: 20.minutes.ago,
                                         end_date: Time.zone.now,
                                         hourly_payment: 6000,
                                         currency: 1,
                                         anonymous: false) }
end
