namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    p = Project.create(name:"test Project")
    g = Group.create(name: "test", project_id:p.id)
    u = User.create!(name: "Example User",
                 email: "example@railstutorial.org", group_id:g.id)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      User.create!(name: name,
                   email: email, group_id:g.id)
    end
  end
end