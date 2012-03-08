Factory.define :email do |email|
  email.email                 "mhartl@example.com"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart2@example.com"
  email.alt_email             "mhart2@example.com"
  email.expires               Time.now + 50.days
  email.reminder_send         false
end

Factory.define :email_expires_in_two_days do |email|
  email.email                 "mhart65@example.com"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart542@example.com"
  email.alt_email             "mhart542@example.com"
  email.expires               Time.now + 2.days
  email.reminder_send         false
end

Factory.define :email_expires_reminder_send do |email|
  email.email                 "mhart4@example.com"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart5@example.com"
  email.alt_email             "mhart6@example.com"
  email.expires               Time.now + 2.days
  email.reminder_send         true
end