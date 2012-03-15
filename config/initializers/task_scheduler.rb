require 'rubygems'
require 'rufus/scheduler'
require('./lib/tasks/saving_last_activity.rb')
require('./lib/tasks/log_parser.rb')
require('./lib/tasks/check_emails_for_expire.rb')
 
scheduler = Rufus::Scheduler.start_new

scheduler.every(Rails.env == "test" ? "23h" : APP_CONFIG["email_background_task"]) do
 puts "#{Time.now}: Parse emails logs"
 LogParser.new 
 puts "#{Time.now}: Check activity of emails"
 CheckEmailsForExpire.new
 puts "#{Time.now}: Check for emails that are expired" 
 CheckEmailsForExpire.new
end