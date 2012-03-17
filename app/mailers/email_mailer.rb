class EmailMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def expires_email(email)
    @email = email
    mail(:to => email.alt_email, :subject => "Your Email address '#{email.email}' expires soon!")
  end
  
  def reset_password_instructions(email)
    @email = email
    mail(:to => email.alt_email, :subject => "Reset password instructions")
  end
  
end
