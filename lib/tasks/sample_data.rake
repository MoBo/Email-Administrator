namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    5.times do |n|
      name  = Faker::Internet.domain_name
      Domain.create!(name: name)  
    end
    5.times do |n|
      # :address, :password, :comment, :expires, :path, :foward_email, :receive, :alt_email 
      data = Hash.new
      data[:address] =  Faker::Internet.email
      data[:password] = Faker::Lorem.words(1)
      data[:comment] = Faker::Lorem.sentences(n+1)
      data[:expires] = n.day.from_now
      data[:path] = "/default/path"
      data[:foward_email] = Faker::Internet.email if (n%3).zero?
      data[:receive] = (n%2).zero?
      data[:alt_email] = Faker::Internet.email if (n%2).zero?
      Email.create!(data)  
    end
  end
end