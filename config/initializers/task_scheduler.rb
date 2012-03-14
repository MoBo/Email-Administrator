require 'rubygems'
require 'rufus/scheduler'
#require email class 
#require 'app/models/email.rb'
 
scheduler = Rufus::Scheduler.start_new
 
scheduler.every("15m") do
  Rails.logger "Deleting user "
   puts "deleting User"
   @emails = Email.get_emails_expires_soon
   # send emails to all in emails container
   @emails.each do |email|
     EmailMailer.expires_email(email).deliver
     # save email send in emails if successfull 
     email.set_reminder_send(true)
   end
   
   # deactivate emails that did not response to the remainder
   @emails_to_deactivate = Email.get_emails_expired
   @emails_to_deactivate.each do |email|
     email.deactivate
   end
   
end

scheduler.every("10m") do
  Rails.logger "Executing the parsing "
  exec "var/www/Email-Administrator/lib/tasks/log2mysql.rb --mysql-server localhost --mysql-user root --mysql-passwd root --mysql-db postfix /var/log/mail.info"
end
