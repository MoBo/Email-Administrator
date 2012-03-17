namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    Domain.create!(name: "sauli.de")
    5.times do |n|
      name  = Faker::Internet.domain_name
      Domain.create!(name: name)  
    end
    Email.create!(email: "ich@sauli.de", password: "foobar", domain_id: 1,admin: "true", email_path: "#{APP_CONFIG["email_default_save_path"]}ich@sauli.de", :expires_on => 10.day.from_now, alt_email: "moritz.bode@gmail.com")
    60.times do |n|
      # :address, :password, :comment, :expires, :path, :foward_email, :receive, :alt_email 
      data = Hash.new
      domain = Domain.find(rand(1...5))
      data[:email] =  Faker::Internet.user_name
      data[:password] = "aaaaaa"
      data[:comment] = Faker::Lorem.words(n+10)
      data[:expires_on] = n.day.from_now
      data[:domain_id] = domain.id
      data[:email_path] = "#{APP_CONFIG["email_default_save_path"]}#{data[:email]}@#{domain.name}"
      data[:forwards] = Faker::Internet.email if (n%3).zero?
      data[:can_receive] = (n%2).zero?
      data[:can_send] = (n%3).zero?
      data[:alt_email] = Faker::Internet.email
      data[:last_activity_on] = Time.now
      Email.create!(data)  
    end
  end
end