# Rake задача для заполнения базы данных образцами пользователей
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
    admin = User.create!(name: "Darja Jestin",
                         email: "jestin.darja@gmail.com",
                         password: "2Bilingual",
                         password_confirmation: "2Bilingual",
                         admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end