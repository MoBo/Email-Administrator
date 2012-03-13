Factory.define :email_expires_in_two_days , :class => :email do |email|
  email.email                 "mhart65"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart542@example.com"
  email.alt_email             "mhart542@example.com"
  email.expires               Time.now + 2.days
  email.reminder_send         false
  email.email_path_id               1
  email.domain_id             1
end

Factory.define :email do |email|
  email.email                 "mhartl"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart2@example.com"
  email.alt_email             "mhart2@example.com"
  email.expires               Time.now + 50.days
  email.reminder_send         false
  email.email_path_id           1
  email.domain_id               1
end

Factory.define :admin do |admin|
  admin.email   "ich@sauli.de"
  admin.password "foobar"
end

Factory.define :email_expires_reminder_send , :class => :email do |email|
  email.email                 "mhart4"
  email.password              "foobar"
  email.password_confirmation "foobar"
  email.forward_email         "mhart5@example.com"
  email.alt_email             "mhart6@example.com"
  email.expires               Time.now + 2.days
  email.reminder_send         true
  email.email_path_id         1
  email.domain_id             1
end

Factory.define :email_path do
  
end

Factory.sequence(:domain_name) do |n|
  "#{n}example.com"
end

Factory.define :domain_seq, :class => :domain do |d|
 d.name Factory.next(:domain_name)
end

Factory.define :domain do |d|
 d.name "test.com"
end

