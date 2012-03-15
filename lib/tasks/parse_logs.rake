require('./lib/tasks/log_parser.rb')
namespace :log do
  desc "Fill database with sample data"
  task parse: :environment do
    LogParser.new
  end
end