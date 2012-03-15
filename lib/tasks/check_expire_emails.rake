namespace :emails do
  task expire: :environment do
    CheckEmailsForExpire.new
  end
end
class CheckEmailsForExpire
  def initialize
    self.check_expire
  end
  
  def check_expire
    @emails = Email.get_emails_expires_soon
    # send emails to all in emails container
    @emails.each do |email|
      EmailMailer.expires_email(email).deliver
      # save email send in emails if successfull
      email.set_reminder_send(true)
      puts "#{Time.now}: reminder email was send for #{email.email}"
    end

    # deactivate emails that did not response to the remainder
    @emails_to_deactivate = Email.get_emails_expired
    @emails_to_deactivate.each do |email|
      email.deactivate
      puts "#{Time.now}: email: #{email.email} was deactivated"
    end
  end

end