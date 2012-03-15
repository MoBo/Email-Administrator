require('./lib/tasks/saving_last_activity.rb')
namespace :log do
  task save: :environment do
    SavingLastActivity.new
  end
end

