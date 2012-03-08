require 'rubygems'
require 'rufus/scheduler'
#require email class 
#require 'app/models/email.rb'
 
scheduler = Rufus::Scheduler.start_new
 
scheduler.every("10s") do
   puts "deleting User"
   Email.create(:email => "kaka")
end