namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    User.create!(name: "Example User",
                 email: "example@railstutorial.org")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      User.create!(name: name,
                   email: email)
    end
  end
end