require('./lib/tasks/check_emails_for_expire.rb')
namespace :emails do
  task expire: :environment do
    CheckEmailsForExpire.new
  end
end