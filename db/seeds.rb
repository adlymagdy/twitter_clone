User.create!(name: "Adly Magdy",
             email: "adly.tadros@yahoo.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             

User.create!(name: "Maged Ishak",
             email: "maged0ishak@yahoo.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  name =  Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = 'foobar'
  User.create!(name: name,
             email: email,
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }