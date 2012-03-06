namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    5.times do |n|
      name  = Faker::Internet.domain_name
      Domain.create!(name: name)  
    end
  end
end