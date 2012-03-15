class EmailMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def expires_email(email)
    @email = email
    mail(:to => email.alt_email, :subject => "Your Email adresse '#{email.email}' expires soon!")
  end
end
