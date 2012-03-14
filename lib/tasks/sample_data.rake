namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    Domain.create!(name: "sauli.de")
    5.times do |n|
      name  = Faker::Internet.domain_name
      Domain.create!(name: name)  
    end
    Email.create!(email: "ich@sauli.de", password: "foobar", domain_id: 1,admin: "true", email_path: "/var/logs/")
    60.times do |n|
      # :address, :password, :comment, :expires, :path, :foward_email, :receive, :alt_email 
      data = Hash.new
      domain = Domain.find(rand(1...5))
      data[:email] =  Faker::Internet.user_name
      data[:password] = "aaaaaa"
      data[:comment] = Faker::Lorem.words(n+10)
      data[:expires_on] = n.day.from_now
      data[:domain_id] = domain.id
      data[:email_path] = "/"+ Faker::Internet.domain_word + "/" + Faker::Internet.domain_word + "/"
      data[:forward_email] = Faker::Internet.email if (n%3).zero?
      data[:receive] = (n%2).zero?
      data[:alt_email] = Faker::Internet.email if (n%2).zero?
      Email.create!(data)  
    end
  end
end