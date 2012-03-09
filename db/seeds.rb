# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


path = "/tmp/"

Domain.create([{:name => "google.cn"}, {:name => "zoo.de"}, {:name => "hockey.de"}, {:name => "lab.com"}])
EmailPath.create(:path => path,:type => "default")
