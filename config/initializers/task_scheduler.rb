require 'rubygems'
require 'rufus/scheduler'
#require email class 
#require 'app/models/email.rb'
 
scheduler = Rufus::Scheduler.start_new
 
scheduler.every("10s") do
   puts "deleting User"
   @emails = Email.where(:expires => (Time.now)..(Time.now + 14.days), :reminder_send => false)
   # send emails to all in emails container
   
   # save email send in emails if successfull
   
   # delete emails that did not response to the remainder
   @remove_emails = Email.where(:expires => Time.now)
end