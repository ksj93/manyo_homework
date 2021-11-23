# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
   email: 'test@test.com',
   name: 'admin',
   password: '12345',
   authority: 1
)
10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "test_user#{n + 1}",
    password: '12345',
  )
end
10.times do |m|
  10.times do |n|
    Task.create!(
      title:"test_task#{n+1}",
      content:"test#{n+1}",
      status:"未着手",
      deadline:"2022-01-01",
      # priority:0,
      user_id: m+2
    )
  end
end
Label.create!(tag:"Ruby on Rails")
Label.create!(tag:"JavaScript")
Label.create!(tag:"Ruby")
Label.create!(tag:"Django")
Label.create!(tag:"pyhton")
Label.create!(tag:"C")
Label.create!(tag:"C+")
Label.create!(tag:"C#")
Label.create!(tag:"Java")
Label.create!(tag:"HTML")
Label.create!(tag:"node.js")
Label.create!(tag:"vue.js")
