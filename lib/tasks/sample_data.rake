namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "miszmaniac",
                 email: "miszmaniac@gmail.com",
                 password: "haslo123",
                 password_confirmation: "haslo123")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@tabugame.pl"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end