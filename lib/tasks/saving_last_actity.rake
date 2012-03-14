namespace :log do
  task save: :environment do
    SavingLastActivity.new
  end
end

class SavingLastActivity
  
  def initialize
    self.save_for_outgoings
    self.save_for_incoming
  end
  
  def save_for_outgoings
    OutgoingLog.select('recipient, max(action_time) as action_time').group('recipient').each do |outgoing|
      email = Email.find_by_email(outgoing.recipient)
      puts "look for #{outgoing.recipient} outgoing"
      if email
        puts "email found #{email.email} outgoing"
        if outgoing.action_time > email.last_activity_on
          puts "#{email.email} was updated to#{outgoing.action_time} outgoing"
          email.update_attribute(:last_activity_on, outgoing.action_time)
        end
      end
    end
  end
  
  def save_for_incoming
    IncomingLog.select('sender, max(arrive_time) as arrive_time').group('sender').each do |incoming|
      email = Email.find_by_email(incoming.sender)
      puts "look for #{incoming.sender} incoming"
      if email
        puts "email found #{email.email} incoming"
        if incoming.arrive_time > email.last_activity_on
          puts "#{email.email} was updated to#{incoming.arrive_time} incoming"
          email.update_attribute(:last_activity_on, incoming.arrive_time)
        end
      end
    end
  end
  
end

