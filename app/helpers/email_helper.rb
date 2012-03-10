module EmailHelper
  def get_email_prefix(email)
    email.sub(/@.*/,"")
  end
end
